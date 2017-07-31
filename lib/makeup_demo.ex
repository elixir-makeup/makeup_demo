defmodule MakeupDemo do
  def make() do
    output_dir = "website"
    # Create the output dir if it doesn't exist already
    File.mkdir_p!(output_dir)
    # Copy the static files (not the code stylesheets,
    # those are dynamically generated)
    File.cp_r!("assets/_static", output_dir <> "/_static")
    # Write the stylesheets for the themes
    MakeupDemo.Languages.write_makeup_stylesheets(output_dir <> "/_static/css")
    # Webpages:
    # - Index
    File.write!(
      output_dir <> "/index.html",
      MakeupDemo.Views.render_index)
    # Language pages
    for %{slug: slug} = language <- MakeupDemo.Languages.languages() do
      content = MakeupDemo.Views.render_language(language)
      File.write!(
        output_dir <> "/#{slug}.html",
        content
      )
    end

    IO.puts("Done.")
    :ok
  end
end
