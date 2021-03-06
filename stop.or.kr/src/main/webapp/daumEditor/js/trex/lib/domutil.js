/** @namespace */
var $tom = {};

(function() {
	var __TRANSLATIONS = {
		'%body': ['body'],
		'%text': ['#text', 'br'],
		'%element': ['#element'],
		'%control': ['img','object','hr','table','button','iframe'], //['input','select','textarea','label','br'],
		'%inline': ['span','font','u','i','b','em','strong','big','small','a','sub','sup','span'],//['tt','dfn','code','samp','kbd','var','cite','abbr','acronym','img','object','br','script','map','q','bdo','input','select','textarea','label','button'],
		'%block': ['p','div','ul','ol','h1','h2','h3','h4','h5','h6','pre','dl','hr','table','button'], //['noscript','blockquote','form','fieldset','address'], !button
		'%paragraph': ['p','li','dd','dt','h1','h2','h3','h4','h5','h6','td','th','div','caption'], //!button
		'%wrapper': ['div','ul','ol','dl','pre','xmp','table','button','blockquote'],// FTDUEDTR-1412
        '%innergroup': ['li','dd','dt','td', 'th'],
		'%outergroup': ['ul','ol','dl','tr','tbody','thead','tfoot','table'],
		'%tablegroup': ['td', 'th','tr','tbody','thead','tfoot','table'],
		'%listgroup': ['li','ul','ol'],
		'%datagroup': ['dd','dt','dl'],
		'%listhead': ['ul','ol']
	};
	
	var __TRANSLATIONS_MAP = {}; //for caching
	for(var _ptrn in __TRANSLATIONS) {
		__TRANSLATIONS_MAP[_ptrn] = {};
		if (__TRANSLATIONS[_ptrn]) {
			$A(__TRANSLATIONS[_ptrn]).each(function(tag){
				__TRANSLATIONS_MAP[_ptrn][tag] = _TRUE;
			});
		}
	}
	
	function createMap(patterns) {
		var _map = {};
		var _patterns = patterns.split(",");
		_patterns.each(function(pattern) {
			if(__TRANSLATIONS_MAP[pattern]) {
				for(var _part in __TRANSLATIONS_MAP[pattern]) {
					_map[_part] = _TRUE;
				}
			} else {
				_map[pattern] = _TRUE;
			}
		});
		return _map;
	}
	
	var Translator = Trex.Class.create({
		initialize: function(patterns) {
			this.patterns = patterns;
			this.map = createMap(patterns);
		},
		hasParts: function() {
			return (this.patterns.length > 0);
		},
		include: function(partPtrn) {
			var _partMap = createMap(partPtrn);
			for(var _part in _partMap) {
				if(this.map[_part]) {
					return _TRUE;
				}
			}
			return _FALSE;
		},
		memberOf: function(wholePtrn) {
			var _wholeMap = createMap(wholePtrn);
			for(var _part in this.map) {
				if(_wholeMap[_part]) {
					return _TRUE;
				}
			}
			return _FALSE;
		},
		extract: function(wholePtrn) {
			var _wholeMap = createMap(wholePtrn);
			var _matches = [];
			for(var _part in this.map) {
				if(_wholeMap[_part]) {
					_matches.push(_part);
				}
			}
			return $tom.translate(_matches.join(","));
		},
		getExpression: function() {
			if(!this.exprs) {
				var _exprs = [];
				for(var _part in this.map) {
					_exprs.push(_part);
				}
				this.exprs = _exprs.join(",");
			}
			return this.exprs;
		}
	});
	
	var __TRANSLATOR_CACHES = {}; //for caching	
	Object.extend($tom, {
		translate: function(pattern) {
			if(!__TRANSLATOR_CACHES[pattern]) {
				__TRANSLATOR_CACHES[pattern] = new Translator(pattern);
			}
			return __TRANSLATOR_CACHES[pattern];
		}
	});
	
})();

Object.extend($tom, {
	__POSITION: {
		__START_OF_TEXT: -1,
		__MIDDLE_OF_TEXT: 0,
		__END_OF_TEXT: 1,
		__EMPTY_TEXT: -2
	}
});

Object.extend($tom, /** @lends $tom */{
	/**
	 * node??? HTMLElement?????? true??? ????????? false??? ????????????.
	 * @function
	 */
	isElement: function(node) {
        return node && node.nodeType == 1;
	},
	/**
	 * node??? <body> ???????????? true??? ????????????.
	 * @function
	 */
	isBody: function(node) {
        return $tom.isElement(node) && node.tagName == "BODY";
	},
	/**
	 * node??? ????????? ????????? block ???????????? true ??? ????????????.
	 * 'p','div','ul','ol','h1','h2','h3','h4','h5','h6','pre','dl','hr','table','button'
	 * @function
	 */
	isBlock: function(node) {
		return $tom.kindOf(node, '%block');
	},
    /**
	 * node??? ????????? ????????? ???????????? true ??? ????????????.
	 * 'p','li','dd','dt','h1','h2','h3','h4','h5','h6','td','th','div','caption'
	 * @function
	 */
	isParagraph: function(node) {
        return $tom.kindOf(node, '%paragraph');
	},
	/**
	 * node??? ?????????????????? <br> ???????????? true ??? ????????????.
	 * @function
	 */
	isText: function(node) {
		return $tom.kindOf(node, '%text');
	},
	/**
	 * node??? ????????? ????????? ???????????? true??? ????????????.
	 * 'img','object','hr','table','button'
	 * @function
	 */
	isControl: function(node) {
		return $tom.kindOf(node, '%control');
	},
    /**
     * element??? tagName??? true??? ????????????.
     * @function
     */
    isTagName: function(element, tagName){
        tagName = tagName.toUpperCase();
        return element && element.tagName === tagName;

    },
    getOwnerDocument: function(node) {
        return node.ownerDocument || node.document;
    },
	/**
	 * node??? ????????? ????????????.
	 * @function
	 */
	getName: function(node) {
		return ((node && node.nodeType == 1)? node.nodeName.toLowerCase(): "");
	},
	/**
	 * node??? text content ??? ????????????.
	 * @function
	 */
	getText: function(node) {
		return node.textContent || node.text || node.innerText || "";
	},
	/**
	 * ????????? nodeType 1?????? child ????????? ?????????, nodeType 3?????? nodeValue??? ????????? ????????????.  
	 * @function
	 */
	getLength: function(node) {
		if(!node) {
			return 0;
		}
		if(node.nodeType == 1) {
			return node.childNodes.length;
		} else if(node.nodeType == 3) {
			return node.nodeValue.length;
		}
		return 0; 
	},
	/**
	 * node??? ?????? ????????? ?????? ??? ??? ???????????? ??????????????? ????????????.
	 * @function
	 */
	indexOf: function(node){
		if(!node) {
			return -1;
		}
		var _pNode = node.parentNode;
        for (var i = 0, len = _pNode.childNodes.length, childNodes = _pNode.childNodes; i < len; i++) {
            if (childNodes[i] == node) {
                return i;
            }
        }
        return -1;
	},
	/**
	 * node??? textNode?????? ????????? ????????? nodeValue??? ????????? ???????????? true??? ????????????.
	 * @function
	 */
	hasContent: function(node, ignoreZWNBS) {
		if(!node || node.nodeType != 3) {
			return _TRUE;
		}

		var _text = $tom.removeMeaninglessSpace( node.nodeValue );
		if(ignoreZWNBS) {
			_text = _text.replace(Trex.__WORD_JOINER_REGEXP, "");
		}
		return (_text != "");
	},
    removeEmptyTextNode: function(textNode) {
        if (textNode && textNode.nodeType == 3 && !textNode.nodeValue) {
            $tom.remove(textNode);
        }
    },
	hasUsefulChildren: function(node, ignoreZWNBS) {
		if(!node) {
			return _FALSE;
		}
		var _inner = $tom.removeMeaninglessSpace( node.innerHTML );
		if(ignoreZWNBS) {
			_inner = _inner.replace(Trex.__WORD_JOINER_REGEXP, "");
		}
		if(!_inner) {
			return _FALSE;
		}
		if(_inner.stripTags()) {
			return _TRUE;
		}
		if(_inner.search(/<(img|br|hr)\s?[^>]*>/i) > -1) {
			return _TRUE;
		}
		if(_inner.search(/<span\sid="?tx_(start|end)_marker"?><\/span>/i) > -1) {
			return _TRUE;
		}
		return _FALSE;
	},
	/**
	 * node??? ???????????? ???????????? ????????? ????????????.
	 * @function
	 */
	hasData: function(node, ignoreStuff) {
		if(!node) {
			return _FALSE;
		}
		
		var _inner = '';
		if(node.nodeType == 1) {
			_inner = node.innerHTML;
		} else {
			_inner = node.nodeValue;
		}
		_inner = $tom.removeMeaninglessSpace( _inner );
		if(_inner.trim() == '') {// #PCCAFEQA-11
			return _FALSE;
		}
		if(_inner.stripTags() != '') {
			return _TRUE;
		}
		if(ignoreStuff) {
			return _FALSE;
		}
		if(_inner.search(/<br\s?\/?>/i) > -1) {
			return _TRUE;
		}
		return _FALSE;
	},
	/**
	 * ????????? ??????????????? ???????????? ??????????????? ???????????? ??????.
	 * @function
	 */
	removeMeaninglessSpace: function(str){
		/* /\s/ == /[\f\n\r\t\v\u2028\u2029\u00a0]/ */
		return str.replace(/(^[\f\n\r\t\v\u2028\u2029]*)|([\f\n\r\t\v\u2028\u2029]*$)/g, "");
	}
});	

Object.extend($tom, /** @lends $tom */{
	/**
	 * $tom.find, $tom.collect, $tom.collectAll ?????? ??????????????? ???????????? ??????.
	 * @function
	 * @example
	 *   var result1 = $tom.search(["td,th"], dFindy, _NULL);
	 *   var result2 = $tom.search([context, "td,th"], dFindy, _NULL);
	 *   var results = $tom.search([context, "td,th"], dGetties, []);
	 */
	search: function(args, searchFunction, defaultValue) {
		var context = (args.length == 1) ? _DOC : args[0];
		var pattern = args[args.length - 1];
		
		var invalidArgument = (!pattern ||
								!context ||
								!context.nodeType ||
								typeof pattern != "string");
		if (invalidArgument) {
			return defaultValue;
		}
		
		var translator = $tom.translate(pattern);
		return searchFunction(context, translator.getExpression());
	},
	/**
	 * css selector ??? ????????? ????????? ??????????????? ?????? node??? ????????? ?????? ????????? ?????????.
	 * @function
	 * @example
	 *  var _elNode = $tom.find(node, "table.txc-layout-wz");
	 */
	find: function() {
		return this.search(arguments, dFindy, _NULL);
	},
	/**
	 * css selector ??? ????????? ????????? ??????????????? ?????? node??? ????????? ?????? ????????? ?????????.
	 * @function
	 * @example
	 *  var _elInput = $tom.collect(this.elMenu, 'textarea');
	 */
	collect: function() {
		return this.search(arguments, dGetty, _NULL);
	},
	/**
	 * css selector??? ????????? ????????? ??????????????? ?????? node??? ????????? ?????? ????????? ?????? ?????? ????????? ????????? ????????? ????????????.
	 * @function
	 * @example
	 *  var _elItemList = $tom.collectAll(this.elMenu, "li a");  
	 */
	collectAll: function() {
		return this.search(arguments, dGetties, []);
	}
});	

(function() {
	function makeFilter(pattern) {
		if(pattern) {
			if(typeof(pattern) === 'function') {
				return pattern;
			} else {
				var _translator = $tom.translate(pattern);
				return function(node) {
					if(node.nodeType == 1) {
						if (_translator.include('#element')) {
							return _TRUE;
						} else {
							return dChecky(node, _translator.getExpression());
						}
					} else {
						return _translator.include('#text');
					}
				};
			}
		} else {
			return _NULL;
		}
	}

    var nodePatternCache = {};
    function findNodePattern(pattern) {
        pattern = pattern || "#element,#text";

        if (nodePatternCache[pattern]) {
            return nodePatternCache[pattern];
        }
        var filter = new NodePattern(pattern);
        nodePatternCache[pattern] = filter;
        return filter;
    }

    var NodePattern = Trex.Class.create({
        initialize: function(pattern) {
            this.pattern = pattern;
            this.translator = $tom.translate(pattern);
            // for better performance
            this.hasClassPattern = pattern.indexOf(".") >= 0;
            this.hasIdPattern = pattern.indexOf("#") >= 0;
            this.matchesText = this.translator.include("#text");
            this.matchesElement = this.translator.include("#element");
        },
        test: function(node) {
            var nodeType = node.nodeType;
            var translatorMap = this.translator.map;
            if (nodeType == 1) {
                if (this.matchesElement) {
                    return _TRUE;
                }
                var tagName = node.tagName.toLowerCase();

                // early matching for performance
                if (translatorMap[tagName]) {
                    return _TRUE;
                }

                var checkPattern = [];
                if (this.hasClassPattern && node.className) {
                    node.className.split(/\s/).each(function(className) {
                        checkPattern.push("." + className);
                        checkPattern.push(tagName + "." + className);
                    });
                }
                if (this.hasIdPattern && node.id) {
                    var id = node.id;
                    checkPattern.push("#" + id);
                    checkPattern.push(tagName + "#" + id);
                }
                for (var i = 0; i < checkPattern.length; i++) {
                    if (translatorMap[checkPattern[i]]) {
                        return _TRUE;
                    }
                }
                return _FALSE;
            } else if (nodeType == 3) {
                return this.matchesText;
            }
        }
    });

	Object.extend($tom, /** @lends $tom */{
        tagName: function(node, tagName) {
            if (!node) {
                return _NULL;
            }
            return node.tagName;
        },
		/**
		 * node??? pattern??? ?????? ???????????? true??? ????????????. 
		 * @function
		 * @param node
		 * @param pattern css selector rule
		 * @example
		 *  $tom.kindOf(node, "img.txc-image") // node??? txc-image?????? ????????? class????????? ?????? img ???????????? true
		 */
        // ??? ?????? ???????????? ?????? dChecky??? ?????????.
        kindOf: function(node, pattern) {
            if (!node || !pattern) {
                return _FALSE;
            }
            var filter = findNodePattern(pattern);
            return filter.test(node);
        },
		kindOf_old: function(node, pattern) {
			if(!node || !pattern) {
				return _FALSE;
			}
			return makeFilter(pattern)(node);
		},
		/* has filter */
		/**
		 * pattern??? ?????? descendant??? ??????????????? ????????? ????????????.
		 * @function
		 */
		ancestor: function(descendant, pattern) {
			if(!descendant || !descendant.parentNode) {
				return _NULL;
			}
            var filter = findNodePattern(pattern);
			var _node = descendant.parentNode;
			while(_node) {
				if($tom.isBody(_node)) {
					return _NULL;
				}
                if (filter.test(_node)) {
                    break;
                }
				_node = _node.parentNode;
			}
			return _node;
        },
        findAncestor: function(node, matched, mustStop) {
            while (!mustStop(node)) {
                if (matched(node)) {
                    return node;
                }
                node = node.parentNode;
            }
            return _NULL;
        },
        /**
		 * pattern??? ?????? descendant??? ??????????????? ????????? ????????????.
		 * @function
		 */
		descendant: function(ancestor, pattern) {
			var _nodes = $tom.descendants(ancestor, pattern, _TRUE);
			if(_nodes.length == 0) {
				return _NULL;
			}
			return _nodes[0];
		}, 
		/**
		 * pattern??? ?????? descendant??? ?????? ??????????????? ????????? ????????????.
		 * @function
		 */
		descendants: function(ancestor, pattern, single) {
			single = single || _FALSE;
			if(!ancestor || !ancestor.firstChild) {
				return [];
			}
			var _found = _FALSE;
            var filter = findNodePattern(pattern);
			var _nodes = [];
			var _gets = function(parent) {
				if(single && _found) {
					return;
				}
				if(!$tom.first(parent)) {
					return;
				}
				var _chilren = $tom.children(parent);
				for(var i=0,len=_chilren.length;i<len;i++) {
					if (filter.test(_chilren[i])) {
						_nodes.push(_chilren[i]);
						_found = _TRUE;
					} else {
						_gets(_chilren[i]);
					}
				}
			};
			_gets(ancestor);
			return _nodes;
		}, 
		/**
		 * node??? ???????????? ??? pattern??? ?????? ?????? ????????? ????????? ????????????.
		 * @function
		 */
		children: function(node, pattern) {
			var _nodes = [];
			if(!node || !node.firstChild) {
				return _nodes;
			}
            var filter = findNodePattern(pattern);
			var _node = $tom.first(node);
			while(_node) {
                if (filter.test(_node)) {
					_nodes.push(_node);
				}
				_node = _node.nextSibling;
			}
			return _nodes;
		},
		/**
		 * node??? nextSibling ?????? ??? pattern??? ?????? ????????? ????????? ????????????.
		 * @function
		 */
		next: function(node, pattern) {
			if(!node || !node.nextSibling) {
				return _NULL;
			}
            var filter = findNodePattern(pattern);
			var _node = node.nextSibling;
			while(_node) {
				if($tom.hasContent(_node)) {
					if (filter.test(_node)) {
						break;
					}
				}
				_node = _node.nextSibling;
			}
			return _node;
		},
		/**
		 * node??? previousSibling ?????? ??? pattern??? ?????? ????????? ????????? ????????????.
		 * @function
		 */
		previous: function(node, pattern) {
			if(!node || !node.previousSibling) {
				return _NULL;
			}
            var filter = findNodePattern(pattern);
			var _node = node.previousSibling;
			while(_node) {
				if($tom.hasContent(_node)) {
					if (filter.test(_node)) {
						break;
					}
				}
				_node = _node.previousSibling;
			}
			return _node;
		},
		/**
		 * pattern??? ?????? node??? ????????? ??????????????? ????????? ????????????.
		 * @function
		 */
		first: function(node, pattern) {
			if(!node || !node.firstChild) {
				return _NULL;
			}
            var filter = findNodePattern(pattern);
			var _node = node.firstChild;
			while(_node) {
				if($tom.hasContent(_node)) {
                    if (filter.test(_node)) {
                        break;
                    }
				}
				_node = _node.nextSibling;
			}
			return _node;
		},
		/**
		 * pattern??? ?????? node??? ????????? ??????????????? ????????? ????????????.
		 * @function
		 */
		last: function(node, pattern) {
			if(!node || !node.lastChild) {
				return _NULL;
			}
            var filter = findNodePattern(pattern);
			var _node = node.lastChild;
			while(_node) {
				if($tom.hasContent(_node)) {
                    if (filter.test(_node)) {
						break;
					}
				}
				_node = _node.previousSibling;
			}
			return _node;
		},
		/**
		 * 
		 * @function
		 */
		extract: function(parent, child, pattern) {
			var _nodes = [];
			if(!parent || !child ||!pattern) {
				return _nodes;
			}
            var filter = findNodePattern(pattern);
			var _found = _FALSE;
			var _node = parent.firstChild;
			while(_node) {
				if($tom.include(_node, child)) {
					_found = _TRUE;
				}
                if (filter.test(_node)) {
					_nodes.push(_node);
				} else {
					if(_found) {
						break;
					} else {
						_nodes = [];
					}
				}
				_node = _node.nextSibling;
			}
            return _found ? _nodes : [];
//			return _nodes;
		},
		/* has no filter */
		/**
		 * node??? parent node??? ????????????.
		 * @function
		 */
		parent: function(node) {
			if(!node || !node.parentNode) {
				return _NULL;
			}
			return node.parentNode;
		}, 
		/**
		 * node??? ???????????? ?????? body ????????? ????????????.
		 * @function
		 */
		body: function(node) {
			if(!node || !node.parentNode) {
				return _NULL;
			}
			var _node = node.parentNode;
			while(_node) {
				if($tom.isBody(_node)) {
					return _node;
				}
				_node = _node.parentNode;
			}
			return _NULL;
		}, 
		/**
		 * ancestor??? ???????????? ?????? ????????? ????????? ????????? ????????? ????????????. 
		 * @function
		 */
		top: function(ancestor, all) {
			all = all || _FALSE;
			var _node = ancestor;
			
			while($tom.first(_node)) {
				_node = $tom.first(_node);
			}
			if(all) {
				return _node;
			} else {
				if ($tom.kindOf(_node, "#tx_start_marker,#tx_end_marker")) {
					_node = _node.nextSibling || _node.parentNode;
				} else if($tom.kindOf(_node, '%control')) {
					_node = _node.parentNode;
				}
				return _node;
			}
		}, 
		/**
		 * ancestor??? ???????????? ???????????? ????????? ????????? ????????? ????????? ????????????. 
		 * @function
		 */
		bottom: function(ancestor, all) {
			all = all || _FALSE;
			var _node = ancestor;
			while($tom.last(_node)) {
				_node = $tom.last(_node);
			}
			if (all) {
				return _node;
			} else {
				if ($tom.kindOf(_node, "#tx_start_marker,#tx_end_marker")) {
					_node = _node.previousSibling || _node.parentNode;
				} else if ($tom.kindOf(_node, '%control')) {
					_node = _node.parentNode;
				}
				return _node;
			}
		},
		/**
		 * child??? parent??? ???????????? ?????? ???????????? true??? ????????????.
		 * @function
		 */
		include: function(parent, child) {
			if(!parent || !child) {
				return _FALSE;
			}
			if(parent == child) {
				return _TRUE;
			}
			var _node = child;
			while (_node) {
				if ($tom.isBody(_node)) {
					return _FALSE;
				} else if (_node == parent) {
					return _TRUE;
				}
				_node = _node.parentNode;
			}
			return _FALSE;
		},
        /**
         * node, offset ?????? ????????? ????????? ????????????.
         * @function
         */
        prevNodeUntilTagName: function(node, offset, tagName){
            tagName = tagName.toUpperCase();
            if(offset === 0)
                node = node.previousSibling;
            else {
                node = node.childNodes[offset-1];
            }
            while(node&&node.lastChild){
                if(node.tagName === tagName)
                    break;
                node = node.lastChild;
            }
            return node;
        },
        /**
         * node ?????? content??? ????????????.
         * @function
         */
        nextContent : function (node, filter){
            do{
                var _node = $tom.next(node, filter);
                if(_node)
                    return _node;
                node = $tom.parent(node);
            }while(node && !$tom.isBody(node));
            return null;
        }
	});
	
})();



Object.extend($tom, /** @lends $tom */{
	/**
	 * parent????????? ????????? ??????????????? child??? ????????????.
	 * @function
	 */
	insertFirst: function(parent, child) {
		if(!parent || !child) {
			return;
		}
		if (parent.firstChild) {
			parent.insertBefore(child, parent.firstChild);
		} else {
			parent.appendChild(child);
		}
		return child;
	},
	/**
	 * target ?????? ??? ????????? source ????????? ???????????? source ????????? ????????????.
	 * @function
	 */
	insertAt: function(source, target) {
		if(!source || !target) {
			return;
		}
		target.parentNode.insertBefore(source, target);
		return source;
	},
	/**
	 * target ?????? ?????? ????????? source ????????? ???????????? source ????????? ????????????.
	 * @function
	 */
	insertNext: function(source, target) {
		if(!source || !target) {
			return;
		}
        var nextSibling = target.nextSibling;
		if (nextSibling) {
			nextSibling.parentNode.insertBefore(source, nextSibling);
		} else {
			target.parentNode.appendChild(source);
		}
		return source;
	},
	/**
	 * parent ????????? child ????????? ?????? ??? child ????????? ????????????.
	 * @function
	 */
	append: function(parent, child) {
		if(!parent || !child) {
			return;
		}
		parent.appendChild(child);
		return child;
	},
	/**
	 * node ??? ????????????.
	 * @function
	 */
	remove: function(node) {
		if(!node) {
			return;
		}
		if(node.parentNode) {
			node.parentNode.removeChild(node);
		}
		node = _NULL;
	},
	/**
	 * node??? innerHTML??? html??? ?????? node??? ????????????.
	 * @function
	 */
	html: function(node, html) {
		if(!node) {
			return;
		}
		node.innerHTML = html || "";
		return node;
	},
	/**
	 * node??? ????????? ?????????.
	 * @function
	 */
	clean: function(node) {
		return $tom.html(node);
	},
	/**
	 * node?????? ?????? html??? ???????????? node??? ????????????.
	 * @function
	 */
	stuff: function(node, html) {
		if(!node) {
			return node;
		}
		if($tom.hasUsefulChildren(node, _TRUE)) {
			return node;
		}
		if(node.lastChild) {
			var _node = node;
			while (_node.lastChild) {
				_node = _node.lastChild;
			}
			$tom.insertNext(html, _node);
		} else {
			$tom.append(node, html);
		}
		return node;
	}
});

Object.extend($tom, /** @lends $tom */{
    /**
     * child??? ?????? listhead?????? ????????????
     * @param node
     */
    removeListIfEmpty: function(node) {
        while ($tom.kindOf(node, "%listhead") && node.childNodes.length == 1 && $tom.kindOf(node.firstChild, "%listhead")) {
            node = node.firstChild;
        }

        while ($tom.kindOf(node, "%listhead") && node.childNodes.length == 0) {
            var tempNode = node.parentNode;
            $tom.remove(node);
            node = tempNode;
        }
    }
});

Object.extend($tom, /** @lends $tom */{
	/**
	 * sNode??? ?????????????????? dNode??? child??? ?????? ????????? sInx, eInx??? ??????????????? ??????, ??? ??????????????????.
	 * @function
	 * @param sNode
	 * @param dNode
	 * @param sInx
	 * @param eInx
	 */
	moveChild: function(sNode, dNode, sInx, eInx) {
		if(!sNode || !dNode) {
			return;
		}
		sInx = Math.min(Math.max(sInx || 0), sNode.childNodes.length);
		eInx = Math.min(Math.max(eInx || sNode.childNodes.length), sNode.childNodes.length);
		if(sInx >= eInx) {
			return;
		}
		
		var _inx = sInx;
		while (_inx++ < eInx && sInx < sNode.childNodes.length) {
			dNode.appendChild(sNode.childNodes[sInx]);
		}
	},
	/**
	 * node??? ??????????????? node??? ??????????????? ?????????.
	 * @function
	 */
	moveChildToParent: function(node) {
		if(!node) {
			return;
		}
        while (node.firstChild) {
            node.parentNode.insertBefore(node.firstChild, node);
        }
	}
});

/*
 * Create, Destroy, Change
 */
Object.extend($tom, /** @lends $tom */{
	/**
	 * source??? target??? ???????????? target??? ????????????.
	 * @function
	 */
    replace: function(source, target) {
        if (!source || !target) {
            return _NULL;
        }
        if ($tom.getName(source) == $tom.getName(target)) {
            $tom.remove(target);
            return source;
        } else {
            // FTDUEDTR-1248
            var children = [],
                childNodes = source.childNodes,
                len = childNodes.length;
            for (var i = 0; i < len; i++) {
                children.push(childNodes[i]);
            }
            for (i = 0; i < len; i++) {
                var child = children[i];
                if (child.lastChild === source) {
                    var cloneChild = $tom.clone(child);
                    $tom.moveChild(child, cloneChild);
                    child.innerHTML = "";
                    target.appendChild(cloneChild);
                } else {
                    target.appendChild(child);
                }
            }
            $tom.insertAt(target, source);
            $tom.remove(source);
            return target;
        }
    },
	/**
	 * node??? ?????? ??? ????????????.
	 * @function
	 */
	clone: function(node, deep) {
        var cloneNode = node.cloneNode(!!deep);
        if (node.nodeType == 1) {
            cloneNode.removeAttribute("id");
        }
        return cloneNode;
	}
});
	
/*
 * Wrap, Unwrap
 */
Object.extend($tom, /** @lends $tom */{
	/**
	 * wNode ????????? pNodes??? ????????? pNodes??? wNode??? ?????????.
	 * @function
	 * @return wNode
	 */
	wrap: function(wNode, pNodes) { //NOTE: quote, quotenodesign, textbox ????????? ?????????, actually using 'div', 'blockquote'
		if (!wNode || !pNodes) {
			return _NULL;
		}
        if (pNodes instanceof Array == _FALSE) {
			pNodes = [].concat(pNodes);
		}

		$tom.insertAt(wNode, pNodes[0]);
		pNodes.each((function(pNode){
			$tom.append(wNode, pNode);
		}));
		return wNode;
	},
	/**
	 * node??? ???????????? node??? ??????????????? node??? ????????? ?????????.
	 * @function
	 */
	unwrap: function(node) { 
		if (!node) {
			return _NULL;
		}
        var _nNode = $tom.first(node);
        if ($tx.msie_nonstd) {
            node.removeNode();  // IE????????? ?????? ??? ??????
        } else {
            $tom.moveChildToParent(node);
            $tom.remove(node);
        }
        return _nNode;
	}
});

	
Object.extend($tom, /** @lends $tom */{
	/**
	 * @private
	 * @function
	 */
	divideText: function(node, offset) {
		if(!$tom.isText(node)) {
			return node;
		}
		if(offset <= 0 || offset >= node.length) { //??????????????? ??????????
			return node;
		}
		var _newNode = node.cloneNode(_FALSE);
        node.deleteData(offset, node.length - offset);
		_newNode.deleteData(0, offset);
		$tom.insertNext(_newNode, node);
		return _newNode;
	},
	/**
     * node??? offset?????? child??? ???????????? ??? ?????? ????????????.
	 */
	divideNode: function(node, offset) {
		if(!$tom.isElement(node)) {
			return _NULL;
		}
		/*if(offset <= 0 || offset >= node.childNodes.length) { //??????????????? ??????????
			return node;
		}*/
		var _lastOffset = node.childNodes.length - offset;
		var _newNode = node.cloneNode(_FALSE);
		for(var i=0;i<_lastOffset;i++) {
			$tom.insertFirst(_newNode, node.lastChild);
		}
		$tom.insertNext(_newNode, node);
		return _newNode;
	},
    /**
     * divideNode??? ????????????, node??? clone??? ?????? style, attribute??? ?????? ???????????? ??????.
     * divideNode ????????? ?????? legacy ????????? ?????? ???????????????, ???????????? ????????? ???????????? ??? ?????? ????????? ????????? ??????.
     * ?????? ?????? style??? ???????????? ????????? caller?????? ????????? ????????????, ??????????????? ????????? ??? ????????? ??????...
     */
    splitAt: function(node, index) {
        if (!$tom.isElement(node)) {
            return;
        }
        var clonedNode = $tom.clone(node);
        $tom.moveChild(node, clonedNode, index + 1, node.childNodes.length);
        $tom.insertNext(clonedNode, node);
        return clonedNode;
    },
    /**
     * stopAncestor??? dividedPoint??? ancestor ????????? ???
     * stopAncestor??? dividedPoint ????????? table??? ????????? ???
     */
    divideTree: function(stopAncestor, dividedPoint) {
        var currentNode = dividedPoint, offset, parent;
        do {
            parent = currentNode.parentNode;
            offset = $tom.indexOf(currentNode);
            currentNode = $tom.divideNode(parent, offset);
        } while (currentNode.previousSibling != stopAncestor);
        return currentNode;
    },
	/**
	 * @private
	 * @function
	 */
	divideParagraph: function(node) {
		var _node = node;
		var _offset = $tom.indexOf(node);
		
		var _divided = _node;
		while (_node) {
			if ($tom.isBody(_node)) {
				break;
			} else if ($tom.kindOf(_node, 'td,th,%wrapper,%outergroup')) {
				break;
			} else if ($tom.kindOf(_node, "#tx_start_marker,#tx_end_marker")) {
				_offset = $tom.indexOf(_node);
			} else if($tom.isControl(_node)) {
				_offset = $tom.indexOf(_node);
			} else if ($tom.isText(_node)) { //text
				_node = $tom.divideText(_node, _offset);
				_offset = $tom.indexOf(_node);
			} else { //%inline, %paragraph
				_node = $tom.divideNode(_node, _offset);
				_offset = $tom.indexOf(_node);
				_divided = _node;
				if ($tom.kindOf(_node, 'p,li,dd,dt,h1,h2,h3,h4,h5,h6')) {
					break;
				}
			}
			_node = _node.parentNode;
		}
		return _divided;
	},
    wrapInlinesWithP: function(inline, ancestorBlock) {
        var ownerDocument = $tom.getOwnerDocument(inline);
        var inlineNodes = $tom.extract(ancestorBlock || ownerDocument.body, inline, '%text,%inline,%control');
        // caret??? ??? ???????????? ?????????P??? ?????? ????????? ??????
        if (this.hasOnlySavedCaret(inlineNodes, inline)) {
            return _NULL;
        }
        var newParagraph = ownerDocument.createElement("p");
        $tom.wrap(newParagraph, inlineNodes);
        return newParagraph;
    },
    hasOnlySavedCaret: function(inlines, inline) {
        var validInlines = inlines.findAll(function(node) {
            return node.nodeType != 3 || node.nodeValue.trim() != "";
        });
        return this.isGoogRangeCaret(inline) && validInlines.length == 1 && validInlines[0] == inline;
    },
    isGoogRangeCaret: function(node) {
        return node && /goog_[0-9]+/.test(node.id);
    }
});

Object.extend($tom, /** @lends $tom */{
	/**
	 * name??? ??????????????? ????????? ???????????? ??????
	 * @function
	 * @example
	 *  $tom.paragraphOf("table") // 'td'??? ????????????.
	 */
	paragraphOf: function(name) {
		if(!name) {
			return 'p';
		}
		var _translator = $tom.translate(name);
		if (_translator.memberOf('ul,ol')) {
			return 'li';
		} else if (_translator.memberOf('dl')) {
			return 'dd';
		} else if (_translator.memberOf('tr,tbody,thead,tfoot,table')) {
			return 'td';
		} else {
			return 'p';
		}
	},
	/**
	 * 'span' ??? ????????????.
	 * @function
	 */
	inlineOf: function() {
		return 'span';
	},
	/**
	 * ????????? name??? ????????? ??????????????? ?????? ??????????????? ????????????.
	 * @function
	 * @example
	 *  $tom.outerOf("td") // "table"??? ????????????.
	 */
	outerOf: function(name) {
		if(!name) {
			return 'span';
		}
		var _translator = $tom.translate(name);
		if (_translator.memberOf('li')) {
			return 'ol';
		} else if (_translator.memberOf('dd,dt')) {
			return 'dl';
		} else if (_translator.memberOf('td,th,tr')) {
			return 'table';
		} else {
			return 'p';
		}
	}
});
	
(function() {
	var __IGNORE_NAME_FLAG = 0;

	var UnitCalculate = Trex.Class.create({
		$const: {
			__FONT_SIZE_BASIS: 9,
			__REG_EXT_NUMBER: new RegExp("[0-9\.]+"),
			__REG_EXT_UNIT: new RegExp("px|pt|em")
		},
		initialize: function() {
			this.unitConverter = { //1em = 9pt
				"px2em": 1 / 12,
				"px2pt": 9 / 12,
				"em2px": 12, // 12 : 1
				"em2pt": 9,  // 9 : 1
				"pt2px": 12 / 9,
				"pt2em": 1 / 9
			};
		},
		calculate: function(strA, strB) {
			if (strA == _NULL || strA.length == 0) {
				strA = "0em";
			}
			if (strB == _NULL || strB.length == 0) {
				strB = "0em";
			}
	
			var _sign = this.extractSign(strB);
			
			var _unitA = this.extractUnit(strA);
			var _unitB = this.extractUnit(strB); //basis unit
			
			var _numA = this.extractNumber(strA).toNumber();
			var _numB = this.extractNumber(strB).toNumber();
			if(_unitA != _unitB) { //different unit
				if(this.unitConverter[_unitA+"2"+_unitB]) {
					_numA *= this.unitConverter[_unitA+"2"+_unitB];
				}
			}
			var _result = 0;
			if(_sign == "-") {
				_result = Math.max(_numA - _numB, 0);
			} else {
				_result = (_numA + _numB);
			} 
			_result = (Math.round(_result*10)/10);
			if (_result == 0) {
				return _NULL;
			} else {
				return _result + _unitB;
			}
		},
		needCalculation: function(str) {
			if(str == _NULL || typeof str != "string") {
				return _FALSE;
			} else {
				return (str.charAt(0) == '+' || str.charAt(0) == '-');
			}
		},
		extractSign: function(str) {
			var _sign = "+";
			if(str.charAt(0) == '+' || str.charAt(0) == '-') {
				_sign = str.charAt(0);
			}
			return _sign;
		},
		extractNumber: function(str) {
			var _num = 0;
			var _match;
			if((_match = str.match(UnitCalculate.__REG_EXT_NUMBER)) != _NULL) {
				_num = _match[0];
			}
			if(str.indexOf("%") > -1) { //%
				_num = _num / 100;
			}
			return _num;
		},
		extractUnit: function(str) {
			var _unit = "em";
			var _match;
			if((_match = str.match(UnitCalculate.__REG_EXT_UNIT)) != _NULL) {
				_unit = _match[0];
			}
			return _unit;
		}
	});
	var _unitCalculator = new UnitCalculate();
	
	var __ATTRIBUTE_TRANSLATIONS = {
	    colspan:   "colSpan",
	    rowspan:   "rowSpan",
	    valign:    "vAlign",
	    datetime:  "dateTime",
	    accesskey: "accessKey",
	    tabindex:  "tabIndex",
	    enctype:   "encType",
	    maxlength: "maxLength",
	    readonly:  "readOnly",
	    longdesc:  "longDesc",
	    cellPadding:  "cellPadding",
	    cellSpacing:  "cellSpacing",
	    more:  "more",
	    less:  "less",
        style: "style"
	};
	
	Object.extend($tom, /** @lends $tom */{ 
		/**
		 * node??? ????????? ?????? attributes ????????? ????????????.
		 * @function
		 * @param {Element} node
		 * @param {JSON} attributes
		 * @example
		 *  $tom.applyAttributes(inNode, {
		 *		'style': { 'fontSize': null },
		 *		'size': null
		 *	});
		 */
		applyAttributes: function(node, attributes) {
			if(!$tom.isElement(node)) {
				return;
			}
			for(var _name in attributes) {
				if(_name == "style") {
					$tom.applyStyles(node, attributes[_name]);
				} else {
					$tom.setAttribute(node, _name, attributes[_name]);
				}
			}
		},
		/**
		 * node??? ????????? ?????? attributes ????????? ????????????.
		 * @function
		 */
		removeAttributes: function(node, attributes) {
			if(!$tom.isElement(node)) {
				return;
			}
			for(var _name in attributes) {
				if(_name == "style") {
					$tom.removeStyles(attributes[_name])
				} else {
					node.removeAttribute(_name, __IGNORE_NAME_FLAG);
				}
			}
		},
		/**
		 * node?????? attrName??? ???????????? ?????? ????????? ?????? ??????
		 * @function
		 * @example
		 *  $tx("tx_image").getAttribute("class") // class????????? ??? ??????
		 */
		getAttribute: function(node, attrName) {
			if(!$tom.isElement(node)) {
				return _NULL;
			}
			if(node && node.getAttribute) {
				return node.getAttribute(__ATTRIBUTE_TRANSLATIONS[attrName] || attrName);
			} else {
				return _NULL;
			}
		},
		/**
		 * node??? attrName??? ????????????, attrValue??? ????????? ?????? ????????? ????????????.
		 * @function
		 */
		setAttribute: function(node, attrName, attrValue) {
			if(!$tom.isElement(node)) {
				return;
			}
			if(attrValue == _NULL || attrValue.length == 0 || attrValue == 0) {
				node.removeAttribute(attrName, __IGNORE_NAME_FLAG);
			} else {
				if(__ATTRIBUTE_TRANSLATIONS[attrName]) {
					node.setAttribute(__ATTRIBUTE_TRANSLATIONS[attrName], attrValue);
				} else {
					try {
						node[attrName] = attrValue;
					} catch(e) {
                        console.log(e);
						node.setAttribute(__ATTRIBUTE_TRANSLATIONS[attrName] || attrName, attrValue);
					}
				}
			}
		},
        // TODO : refactoring ?????? ????????????.
        setStyles: function(node, styles, overwrite) {
            var nodeCssText = node.style.cssText;
            var canSetStyle;
            var styleToSet = Object.extend({}, styles);
            if (styleToSet.font) {
                if (overwrite) {
                    node.style.font = styleToSet.font;  // ??? ???????????? chrome, opera??? font??? css ????????? ????????? ????????? ????????????.
                } else if (node.style.cssText.indexOf("font:") == -1) {
                    node.style.cssText = 'font: ' + styleToSet.font + '; ' + node.style.cssText;
                }
                delete styleToSet.font;
            }
            for (var styleName in styleToSet) {
                var styleValue;
                if (_unitCalculator.needCalculation(styleToSet[styleName])) {
                    styleValue = _unitCalculator.calculate(node.style[styleName], styleToSet[styleName]);
                } else {
                    styleValue = styleToSet[styleName];
                }
                if (styleValue == _NULL) {
                    styleValue = "";
                }

                if (styleName == 'float') {
                    styleName = $tx.msie ? 'styleFloat' : 'cssFloat';
                }
                canSetStyle = (!node.style[styleName] && (styleName.indexOf("font") != 0 || nodeCssText.indexOf("font:") == -1)) || overwrite;
                var newTextDecoration = (styleName == "textDecoration") && !node.style[styleName].include(styleValue);
                if (canSetStyle) {
                    node.style[styleName] = styleValue;
                } else if (newTextDecoration) {
                    node.style[styleName] += " " + styleValue;
                }
            }
            $tom._clearUselessStyle(node);
        },
		/**
		 * node??? styles?????? ????????? ???????????? ????????????.
		 * @function
		 * @example
		 *  $tom.applyStyles(node, {
		 * 		'width': width
		 *  });
		 */
		applyStyles: function(node, styles) {
            this.setStyles(node, styles, _TRUE);
        },
        /**
         * node??? style ???????????? ????????????, ?????? ???????????? ????????? ????????????.
         * @param node
         * @param styles
         */
        addStyles: function(node, styles) {
            this.setStyles(node, styles, _FALSE);
        },
		/**
		 * node?????? styles???????????? ????????? ????????? ???????????? ????????????. 
		 * @function
		 */
		removeStyles: function(node, styles) {
            // FTDUEDTR-1166
            var cssText = node.style.cssText;
            var orignalCssText = cssText;
			for(var _name in styles) {
                _name = _name.replace(/([A-Z])/g, "-$1");
                cssText = cssText.replace(new RegExp("(^| )" + _name + "\\s*:[^;]+;? ?", "ig"), "");
			}
            if (orignalCssText != cssText) {
                node.style.cssText = cssText;
                $tom._clearUselessStyle(node);
            }
		},
        _clearUselessStyle: function(node) {
            var _attrValue = $tom.getAttribute(node, "style");
            if (!_attrValue) { //remove needless style
                node.removeAttribute("style", __IGNORE_NAME_FLAG);
            }
        },
		/**
		 * node?????? style ????????? ???????????? ?????? ????????????.
		 * @function
		 */
		getStyleText: function(node) {
            return node.style.cssText;
		},
		/**
		 * node??? style ???????????? value??? ?????????. ????????? ?????? ?????? ??????????????????.
		 * @function
		 * @param {Element} node
		 * @param {String} value style ????????? ?????? ????????? ????????? ?????? ????????? ???
		 * @example
		 *  $tom.setStyleText($tx("tx_article_category"), "width:50px;height:10px")
		 */
		setStyleText: function(node, value) {
            node.style.cssText = value;
            !value && $tom._clearUselessStyle(node);
		}
	});
})();

Object.extend($tom, /** @lends $tom */{ 
	/**
	 * @private
	 * @function
	 */
	goInto: function(node, toTop) {
		if(!node || !node.scrollIntoView) {
			return;
		}
		node.scrollIntoView(toTop);
	},
	/**
	 * ?????? ????????? ???????????? ????????????.
	 * @function
	 * @example
	 *  $tom.getScrollTop(document)
	 */
	getScrollTop: function(doc) {
		if(!doc) {
			return 0;
		}
		return doc.documentElement.scrollTop >= 0 ? doc.documentElement.scrollTop : doc.body.scrollTop;
	},
	/**
	 * ?????? ????????? ?????? ????????????.
	 * @function
	 * @param {Element} doc
	 * @param {Number} scrollTop ?????? ????????? ???
	 */
	setScrollTop: function(doc, scrollTop) {
		if(!doc) {
			return;
		}
		if(doc.documentElement.scrollTop) {
			doc.documentElement.scrollTop = scrollTop;
		} else {
			doc.body.scrollTop = scrollTop;
		}
	},
	/**
	 * ?????? ????????? ???????????? ????????????.
	 * @function
	 */
	getScrollLeft: function(doc) {
		if(!doc) {
			return 0;
		}
		return (doc.documentElement.scrollLeft || doc.body.scrollLeft);
	},
	/**
	 * ?????? ????????? ?????? ????????????.
	 * @function
	 * @param {Element} doc
	 * @param {Number} scrollLeft ?????? ????????? ???
	 */
	setScrollLeft: function(doc, scrollLeft) {
		if(!doc) {
			return;
		}
		if(doc.documentElement.scrollLeft) {
			doc.documentElement.scrollLeft = scrollLeft;
		} else {
			doc.body.scrollLeft = scrollLeft;
		}
	},
	/**
	 * element????????? left, top, width, height ?????? ???????????? ????????????.
	 * @function
	 * @return {
	 * 		x: 0,
	 * 		y: 0,
	 * 		width: 0,
	 * 		height: 0
	 * 	}
	 */
	getPosition: function(element, cumulative) {
		if(!element) {
			return {
				x: 0,
				y: 0,
				width: 0,
				height: 0
			};
		}
		cumulative = !!cumulative;
		element = $tx(element);
		var pos = (cumulative)? $tx.cumulativeOffset(element): $tx.positionedOffset(element);
		var dim;
		var display = element.style.display;
		if (display != 'none' && display != _NULL) { //Safari bug
			dim = {
				width: element.offsetWidth,
				height: element.offsetHeight
			};
		} else {
			var els = element.style;
			var originalVisibility = els.visibility;
			var originalPosition = els.position;
			var originalDisplay = els.display;
			els.visibility = 'hidden';
			els.position = 'absolute';
			els.display = 'block';
			var originalWidth = element.clientWidth;
			var originalHeight = element.clientHeight;
			els.display = originalDisplay;
			els.position = originalPosition;
			els.visibility = originalVisibility;
			dim = {
				width: originalWidth,
				height: originalHeight
			};
		}
		return {
			x: pos[0],
			y: pos[1],
			width: dim.width,
			height: dim.height
		};
	},
	/**
	 * node ????????? width?????? ????????????.
	 * inline style??? px????????? ???????????? ????????? offset?????? ????????????.
	 * @function
	 */
	getWidth: function(node) {
		var width = node.style["width"];
		if( width.isPx() ){
			return width.parsePx();
		} 
		return node.offsetWidth;
	},
	/**
	 * node ?????? ?????????????????? width ?????? ????????????.
	 * @function
	 */
	setWidth: function(node, width) {
		$tom.applyStyles(node, {
			'width': width
		});
	},
	/**
	 * node ????????? height?????? ????????????.
	 * inline style??? px????????? ???????????? ????????? offset?????? ????????????.
	 * @function
	 */
	getHeight: function(node) {
		var height = node.style["height"];
		if( height.isPx() ){
			return height.parsePx();
		} 
		return node.offsetHeight;
	},
	/**
	 * node ?????? ?????????????????? height ?????? ????????????.
	 * @function
	 */
	setHeight: function(node, height) {
		$tom.applyStyles(node, {
			'height': height
		});
	},
	/**
	 * @private
	 * @function
	 */
	replacePngPath: function(node) {
		if ($tx.msie6) {
			if(_DOC.location.href.indexOf("http://") > -1) {
				return;
			}
			try {
				var _orgFilter = $tx.getStyle(node, 'filter');
				var _orgSrc = /src='([^']+)'/.exec(_orgFilter)[1];
				if(!_orgSrc || _orgSrc == 'none') {
					return;
				} else if(_orgSrc.indexOf("http://") > -1) {
					return;
				}
				
				var _docPathSlices = _DOC.location.href.split("/");
				_docPathSlices.push("css");
				_docPathSlices.pop();
				_orgSrc = _orgSrc.replace(/\.\.\//g, function() {
					_docPathSlices.pop();
					return "";
				});
				
				var _newSrc = _docPathSlices.join("/") + "/" + _orgSrc;
				node.style.filter = _orgFilter.replace(/src='([^']+)'/, "src='" + _newSrc + "'");
			} catch(e) {alert(e)}
		}
	}
});

Object.extend($tom, /** @lends $tom */{
    /**
     * ?????????????????? ?????? ??? ????????? ???????????? content
     * @constant
     */
    EMPTY_BOGUS: ($tx.msie_quirks || $tx.msie && $tx.msie_ver < 11 ? "&nbsp;" : "<br>")
});

Object.extend($tom, /** @lends $tom */{
    /**
	 * ?????????????????? ?????? ??? ????????? ???????????? HTML
	 * @constant
	 */
    EMPTY_PARAGRAPH_HTML: "<p>" + $tom.EMPTY_BOGUS + "</p>"
});

_WIN.$tom = $tom;