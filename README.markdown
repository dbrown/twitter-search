# A simple Summize client for Ruby.

Access the Summize API from your Ruby code.

## Usage

Require the gem.

    require 'summize'

Set up a Summize::Client. Name your client (a.k.a. 'user agent') to something meaningful, such as your app's name. This helps Summize answer any questions about your use of the API.

	  @client = Summize::Client.new 'politweets'
	
Request tweets by calling the query method of your client. It takes either a String or a Hash of arguments.

    @tweets = @client.query 'twitter search'

The String form uses the default Summize behavior, which in this example finds tweets containing both "twitter" and "search". It is identical to:

    @tweets = @client.query :q => 'twitter search'
    
Use Summize's query operators with the :q key to access the following behavior:

<table>
		<tr><th>Operator</th><th>Finds tweets...</th></tr>
    
		<tr><td><a href="/search?q=twitter+search">:q => 'twitter search'</a></td><td>containing both "twitter" and "search". This is the default operator.</td></tr>
		<tr><td><a href="/search?q=%22happy+hour%22">:q => '"happy hour"'</a></td><td>containing the exact phrase "happy hour".</td></tr>
		<tr><td><a href="/search?q=obama+OR+hillary">obama <b>OR</b> hillary</a></td><td>containing either "obama" or "hillary" (or both).</td></tr>
    
		<tr><td><a href="/search?q=beer+-root">beer <b>-</b>root</a></td><td>containing "beer" but not "root".</td></tr>
		<tr><td><a href="/search?q=%23haiku"><b>#</b>haiku</a></td><td>containing the hashtag "haiku".</td></tr>	
		<tr><td><a href="/search?q=from%3Aalexiskold"><b>from:</b>alexiskold</a></td><td>sent from person "alexiskold".</td></tr>	
		<tr><td><a href="/search?q=to%3Atechcrunch"><b>to:</b>techcrunch</a></td><td>sent to person "techcrunch".</td></tr>	
		<tr><td><a href="/search?q=%40mashable"><b>@</b>mashable</a></td><td>referencing person "mashable".</td></tr>
    
		<tr><td><a href="/search?q=%22happy+hour%22+near%3A%22san+francisco%22">"happy hour" <b>near:</b>"san francisco"</a></td><td>containing the exact phrase "happy hour" and sent near "san francisco".</td></tr>
		<tr><td><a href="/search?q=near%3ANYC+within%3A15mi"><b>near:</b>NYC <b>within:</b>15mi</a></td><td>sent within 15 miles of "NYC".</td></tr>	
		<tr><td><a href="/search?q=superhero+since%3A2008-05-01">superhero <b>since:</b>2008-05-01</a></td><td>containing "superhero" and sent since date "2008-05-01" (year-month-day).</td></tr>
    
		<tr><td><a href="/search?q=ftw+until%3A2008-05-03">ftw <b>until:</b>2008-05-03</a></td><td>containing "ftw" and sent up to date "2008-05-03".</td></tr>
		<tr><td><a href="/search?q=movie+-scary+%3A%29">movie -scary <b>:)</b></a></td><td>containing "movie", but not "scary", and with a positive attitude.</td></tr>
		<tr><td><a href="/search?q=flight+%3A%28">flight <b>:(</b></a></td><td>containing "flight" and with a negative attitude.</td></tr>
		<tr><td><a href="/search?q=traffic+%3F">traffic <b>?</b></a></td><td>containing "traffic" and asking a question.</td></tr>
    
		<tr><td><a href="/search?q=hilarious+filter%3Alinks">hilarious <b>filter:links</b></a></td><td>containing "hilarious" and linking to URLs.</td></tr>
</table>

## License

MIT License, same terms as Ruby.

## Authors

Written by Dustin Sallings (dustin@spy.net) and Dan Croak (dcroak@thoughtbot.com).

