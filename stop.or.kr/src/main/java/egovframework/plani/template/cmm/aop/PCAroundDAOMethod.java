package egovframework.plani.template.cmm.aop;

import org.aspectj.lang.ProceedingJoinPoint;

public class PCAroundDAOMethod {

  public Object trace(ProceedingJoinPoint joinPoint) throws Throwable {

    String signatureString = joinPoint.getSignature().toShortString();
    // System.out.println(signatureString + " Pointcut 시작전");

    long start = System.currentTimeMillis();
    try {
      Object result = joinPoint.proceed();
      return result;
    } finally {
      long finish = System.currentTimeMillis();
      // System.out.println(signatureString + " Pointcut 종료");
      // System.out.println(signatureString + " 실행 시간 : " + (finish - start) + "ms");
    }
  }
}
