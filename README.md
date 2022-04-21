# Makeup Demo

To visit the demo, go [here](https://elixir-makeup.github.io/makeup_demo/).

To regenerate the website, run:

    $ mix deps.get
    $ mix run tasks/website_builder.exs

The contents will be generated into the `website` folder.
For updating the production website, checkout the `gh-pages` branch
and move the contents of the `website` folder to the root.
