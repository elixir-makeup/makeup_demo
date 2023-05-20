defmodule MakeupDemo.Languages do
  require Makeup.Styles.HTML.StyleMap
  alias Makeup.Styles.HTML.StyleMap

  alias Makeup.Formatters.HTML.HTMLFormatter

  def get_sources(url) do
    dir = "lib/makeup_demo/examples/#{url}/"
    for file <- File.ls!(dir), do: {file, File.read!(dir <> file)}
  end

  def highlight_html(source, lexer, style) do
    tokens = apply(lexer, :lex, [source])
    css_class = "highlight-" <> style.short_name
    HTMLFormatter.format_as_binary(tokens, css_class: css_class)
  end

  def all_stylesheets() do
    html_styles()
    |> Enum.map(fn style ->
      {style, "highlight-" <> style.short_name}
    end)
    |> Enum.map(fn {style, css_class} ->
      HTMLFormatter.stylesheet(style, css_class)
    end)
    |> Enum.join("\n")
  end

  def write_makeup_stylesheets(static_dir) do
    contents = all_stylesheets()
    File.write!(static_dir <> "/makeup.css", contents)
  end

  def write_group_highlighter_js_file(static_dir) do
    contents = HTMLFormatter.group_highlighter_javascript()
    File.write!(static_dir <> "/matching_groups_highlighter.js", contents)
  end

  def languages(),
    do: [
      %{
        name: "C",
        title: "C Language",
        slug: "c",
        lexer: Makeup.Lexers.CLexer,
        intro: """
        <p>
          A lexer for the C programming language.
        </p>
        """
      },
      %{
        name: "Diff",
        title: "Diffs and patches",
        slug: "diff",
        lexer: Makeup.Lexers.DiffLexer,
        intro: """
        <p>
          A lexer for diffs and patches.
        </p>
        """
      },
      %{
        name: "EEx",
        title: "EEx -  Embedded Elixir template language",
        slug: "eex",
        lexer: Makeup.Lexers.EExLexer,
        intro: """
        <p>
          A lexer for EEx (Embedded Elixir).
        </p>
        """
      },
      %{
        name: "Elixir",
        title: "Elixir Language",
        slug: "elixir",
        lexer: Makeup.Lexers.ElixirLexer,
        intro: """
        <p>
          The Elixir lexers contains three demos:
          a sandbox which shows most of the syntax,
          an example of recognizing (possibly nested) matching delimiters and
          an example of an IEx session.
          The same lexer is used for "normal" elixir code and for an IEx session.
        </p>
        """
      },
      %{
        name: "Erlang",
        title: "Erlang Language",
        slug: "erlang",
        lexer: Makeup.Lexers.ErlangLexer,
        intro: """
        <p>
          A lexer for the Erlang language.
        </p>
        """
      },
      %{
        name: "HEEx",
        title: "HEEx - Phoenix template language (HTML+EEx)",
        slug: "heex",
        lexer: Makeup.Lexers.HEExLexer,
        intro: """
        <p>
          A lexer for HEEx (HTML + Embedded Elixir).
        </p>
        """
      },
      %{
        name: "HTML",
        title: "HTML Language",
        slug: "html",
        lexer: Makeup.Lexers.HTMLLexer,
        intro: """
        <p>
          A lexer for HTML.
        </p>
        """
      }
    ]

  def html_styles() do
    [
      StyleMap.abap_style(),
      StyleMap.algol_style(),
      StyleMap.algol_nu_style(),
      StyleMap.arduino_style(),
      StyleMap.autumn_style(),
      StyleMap.borland_style(),
      StyleMap.bw_style(),
      StyleMap.colorful_style(),
      StyleMap.default_style(),
      StyleMap.dracula_style(),
      StyleMap.emacs_style(),
      StyleMap.friendly_style(),
      StyleMap.fruity_style(),
      StyleMap.igor_style(),
      StyleMap.lovelace_style(),
      StyleMap.manni_style(),
      StyleMap.monokai_style(),
      StyleMap.murphy_style(),
      StyleMap.native_style(),
      StyleMap.paraiso_dark_style(),
      StyleMap.paraiso_light_style(),
      StyleMap.pastie_style(),
      StyleMap.perldoc_style(),
      StyleMap.rainbow_dash_style(),
      StyleMap.rrt_style(),
      StyleMap.tango_style(),
      StyleMap.trac_style(),
      StyleMap.vim_style(),
      StyleMap.vs_style(),
      StyleMap.xcode_style()
    ]
  end
end
