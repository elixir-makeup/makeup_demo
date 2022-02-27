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
      }
      # %{name: "HTML5",
      #   title: "HTML5 Language",
      #   slug: "html5",
      #   lexer: Makeup.Lexers.HTML5Lexer,
      #   intro: """
      #   <p>
      #     HTML5 is extremely liberal regarding what is valid HTML5.
      #     This lexer tries to recognize a sensible subset
      #     (and in certain aspects it's even more permissive than HTML5 itself)
      #   </p>

      #   <p>
      #     The lexer is smart, and tries to match the opening and closing tags
      #     of an HTML element.

      #     It is in act an HTML parser, and not only a lexer.

      #     It will render the text inside an HTML element accoring to the tag name.

      #     For example, the text inside a <code>&lt;em&gt;&lt;/em&gt;</code> element
      #     will be <em>italic</em> and the element inside a
      #     <code>&lt;strong&gt;&lt;/strong&gt;</code> element will be <strong>bold</strong>.

      #     Take a look, for example, at the <a href="#tango">Tango</a> and the
      #     <a href="#colorful">Colorful</a> styles.

      #     In the future, hyperlinks will be underlined.
      #   </p>
      #   """
      # }
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
