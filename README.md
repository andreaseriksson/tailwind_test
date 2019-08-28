# TailwindTest


## Tutorial - Setup Tailwind with PurgeCSS

Create a new Phoenix 1.4+ application (that includes Webpack) with

    mix phx.new tailwind_test
    
And then install dependencies with
   
    mix deps.get

That should be enough for starting the Phoenix application. The next steps is about setting up to Tailwind CSS with PurgeCSS. Enter the app directory with `cd tailwind_test` and run

    mix ecto.create

After the database is created, install the javascript pagackes:

    yarn add tailwindcss postcss-loader @fullhuman/postcss-purgecss --cwd assets
    
Create the file `./assets/postcss.config.js`
	
```js
const purgecss = require('@fullhuman/postcss-purgecss')({
  // Specify the paths to all of the template files in your project
  content: ['../lib/**/*.eex', '../lib/**/*.leex'],

  // Include any special characters you're using in this regular expression
  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || [],
});

module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    ...(process.env.NODE_ENV === 'production' ? [purgecss] : []),
  ],
};
```
    
Next step is to instruct Webpacker to use that file. Edit `assets/webpack.config.js` and change the line

```js
use: [MiniCssExtractPlugin.loader, 'css-loader', 'postcss-loader']
```


    
Edit `app.css` file to add the Tailwind imports recomended in the guide. 

```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Updating the code

To actually use the tailwind css, you need to update the classes in the markup in both `lib/tailwind_test_web/templates/layout/app.html.eex` and `lib/tailwind_test_web/templates/page/index.html.eex`. 

First start with the template file:

	<!DOCTYPE html>
	<html lang="en">
	  <head>
	    <meta charset="utf-8"/>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	    <title>TailwindTest · Phoenix Framework</title>
	    <link rel="stylesheet" href="<%= Routes.static_path(@conn, "/css/app.css") %>"/>
	  </head>
	  <body class="font-thin">
	    <header>
	      <section class="container mx-auto max-w-3xl py-6 px-4 flex items-center justify-between flex-wrap border-b border-gray-400">
	        <a href="http://phoenixframework.org/" class="block">
	          <img src="<%= Routes.static_path(@conn, "/images/phoenix.png") %>" class="h-16 object-contain w-full" alt="Phoenix Framework Logo" />
	        </a>
	        <nav role="navigation" class="block">
	          <ul class="flex">
	            <li><a href="https://hexdocs.pm/phoenix/overview.html" class="text-blue-600">Get Started</a></li>
	          </ul>
	        </nav>
	      </section>
	    </header>
	    <main role="main" class="container mx-auto max-w-3xl py-2">
	      <%= if get_flash(@conn, :error) do %>
	        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4" role="alert">
	          <p><%= get_flash(@conn, :error) %></p>
	        </div>
	      <% end %>
	
	      <%= if get_flash(@conn, :info) do %>
	        <div class="bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4" role="alert">
	          <p><%= get_flash(@conn, :info) %></p>
	        </div>
	      <% end %>
	
	      <%= render @view_module, @view_template, assigns %>
	    </main>
	    <script type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
	  </body>
	</html>


And update `lib/tailwind_test_web/templates/page/index.html.eex` with:

	<section class="bg-gray-200 rounded text-center my-4 py-6">
	  <h1 class="text-4xl my-6 font-thin"><%= gettext "Welcome to %{name}!", name: "Phoenix" %></h1>
	  <p class="text-xl my-6 font-thin">A productive web framework that<br/>does not compromise speed or maintainability.</p>
	</section>
	
	<section class="flex justify-between">
	  <article class="flex-1">
	    <h2 class="text-3xl my-6 font-thin">Resources</h2>
	    <ul class="list-disc list-inside">
	      <li>
	        <a href="https://hexdocs.pm/phoenix/overview.html" class="text-blue-600">Guides &amp; Docs</a>
	      </li>
	      <li>
	        <a href="https://github.com/phoenixframework/phoenix" class="text-blue-600">Source</a>
	      </li>
	      <li>
	        <a href="https://github.com/phoenixframework/phoenix/blob/v1.4/CHANGELOG.md" class="text-blue-600">v1.4 Changelog</a>
	      </li>
	    </ul>
	  </article>
	  <article class="flex-1">
	    <h2 class="text-3xl my-6 font-thin" class="text-blue-600">Help</h2>
	    <ul class="list-disc list-inside">
	      <li>
	        <a href="https://elixirforum.com/c/phoenix-forum" class="text-blue-600">Forum</a>
	      </li>
	      <li>
	        <a href="https://webchat.freenode.net/?channels=elixir-lang" class="text-blue-600">#elixir-lang on Freenode IRC</a>
	      </li>
	      <li>
	        <a href="https://twitter.com/elixirphoenix" class="text-blue-600">Twitter @elixirphoenix</a>
	      </li>
	    </ul>
	  </article>
	</section>


To start your Phoenix server and test that everingthing works. Run

    mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


### Before
![Before](https://res.cloudinary.com/dwvh1fhcg/image/upload/v1559077419/articles/tailwind_test_before.png)

### After
![After](https://res.cloudinary.com/dwvh1fhcg/image/upload/v1559078018/articles/tailwind_test_after.png?a=1)



