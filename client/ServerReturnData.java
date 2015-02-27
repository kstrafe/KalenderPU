package client;

public class ServerReturnData
{
	private java.util.ArrayList<java.util.ArrayList<String>> final_set = new java.util.ArrayList<>();

	public ServerReturnData()
	{}

	public ServerReturnData(String input)
	{
		parseInput(input);
	}

	public void parseInput(String input)
	{
		columns = Integer.parseInt(input.substring(0, input.indexOf(" ") + 1).trim());
		input = input.substring(input.indexOf(" ") + 1);
		java.util.ArrayList<String> result_set = utils.Utils.splitAndUnescapeString(input);
		final_set = new java.util.ArrayList<>();
		for (String str : result_set)
		{
			final_set.add(utils.Utils.splitAndUnescapeString(str));
		}
	}

	public String getPrettyStringRepresentation()
	{
		int i = 0;
		StringBuilder string_builder = new StringBuilder();
		for (String tmp : final_set)
		{
			if (++i % columns == 0)
				string_builder.append('\n');
			string_builder.append("'" + tmp + "', ");
		}
		return string_builder.toString().trim();
	}
}