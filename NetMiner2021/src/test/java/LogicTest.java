public class LogicTest {

	public static void main(String[] ar) {

		int nowPrice = 138600;
		int oldPrice = 68600;
		int nowPricePerDay = (int)Math.round((nowPrice/30)/10.0)*10; // 새로운 플랜가격
		int oldPricePerDay = (int)Math.round((oldPrice/30)/10.0)*10; // 과거 플랜가격
		System.out.println(String.format("(%s, %s), (%s, %s)", oldPrice, oldPricePerDay, nowPrice, nowPricePerDay));
		
		for(int diffDay= 1; diffDay<=23; diffDay++ ) {
			double firstResult = (nowPricePerDay*(30-diffDay)) + (oldPricePerDay*diffDay) - oldPrice;
			int result = (int) Math.round(firstResult);
			
			System.out.println( String.format("diffDay %s > %s*%s + %s*%s - %s = %s", diffDay
					, nowPricePerDay, (30-diffDay), oldPricePerDay, diffDay, oldPrice
					, result) );
		}
	}
}
