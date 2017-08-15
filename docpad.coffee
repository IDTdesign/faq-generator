# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	ignoreCustomPatterns: /^\S*([.]less)/gm

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		cutTag: '<!-- cut -->'

		# Specify some site properties
		site:
			# The production url of our website
			url: "//idtdesign.github.io/faq-generator"

			canonicalUrl: "//idtdesign.github.io/faq-generator"

			# The default title of our website
			title: "FAQ"

			# The website's styles
			styles: [
			]

			# The website's production scripts.
			# See also Environments section below for development scripts
			scripts: [
			]

		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		isActive: (s) ->
			# current links in navigation
			if @document.url == s
				" active "

		# converts whitespaces into dashes "
		wspToDash: (s) ->
			s and (s
				.replace /\ /g, "-"
			)

	# Plugins configurations
	plugins:
		cleanurls:
			static: true
			trailingSlashes: true
		ghpages:
			deployRemote: 'deploy'
			deployBranch: 'gh-pages'

	environments:
		development:
			templateData:
				site:
					url: 'http://localhost:9778'

					# The website's scripts
					scripts: [
					]

	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}

# Export our DocPad Configuration
module.exports = docpadConfig
