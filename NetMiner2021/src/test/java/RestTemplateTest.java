import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

public class RestTemplateTest {

	public static final void main(String []ar) {
		
		URL url = null;
		URLConnection connection = null;
		StringBuilder responseBody = new StringBuilder();
		try {
			url = new URL("https://pay.toss.im/api/v2/status");
			connection = url.openConnection();
			connection.addRequestProperty("Content-Type", "application/json");
			connection.setDoOutput(true);
			connection.setDoInput(true);

			Map<String, Object> map= new HashMap<>();
			map.put("amount", "15000");
			map.put("orderNo", "a4CWyWY5m89PNh7xJwhk1");
			map.put("apiKey", "sk_test_w5lNQylNqa5lNQe013Nq");
			String body= new Gson().toJson(map);

			BufferedOutputStream bos = new BufferedOutputStream(connection.getOutputStream());
			bos.write(body.getBytes(StandardCharsets.UTF_8));
			bos.flush();
			bos.close();

			
		    BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
			String line = null;
			while ((line = br.readLine()) != null) {
				responseBody.append(line);
			}
			br.close();
		} catch (Exception e) {
			responseBody.append(e);
		}
		System.out.println(responseBody.toString());
		
	}
}
