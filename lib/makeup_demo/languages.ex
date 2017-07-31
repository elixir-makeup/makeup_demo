defmodule MakeupDemo.Languages do

  require Makeup.Styles.HTML.StyleMap
  alias Makeup.Styles.HTML.StyleMap

  alias  Makeup.Formatters.HTML.Simple, as: HTMLFormatter

  def get_sources(url) do
    dir = "lib/makeup_demo/examples/#{url}/"
    for file <- File.ls!(dir), do: {file, File.read!(dir <> file)}
  end

  def highlight_html(source, lexer, style) do
    tokens = apply(lexer, :lex, [source])
    css_class = "highlight-" <> style.short_name
    HTMLFormatter.format(tokens, css_class)
  end

  def all_stylesheets() do
    html_styles()
    |> Enum.map(fn style ->
                  {style, "highlight-" <> style.short_name} end)
    |> Enum.map(fn {style, css_class} ->
                  HTMLFormatter.stylesheet(style, css_class) end)
    |> Enum.join("\n")
  end

  def write_makeup_stylesheets(static_dir) do
    contents = all_stylesheets()
    File.write!(static_dir <> "/makeup.css", contents)
  end

  def languages(), do:   [
    %{name: "Elixir",
      title: "Elixir Language",
      slug: "elixir",
      lexer: Makeup.Lexers.Elixir,
      intro: ""
    },
    %{name: "HTML5",
      title: "HTML5 Language",
      slug: "html5",
      lexer: Makeup.Lexers.HTML5,
      intro: """
      <p>
        HTML5 is extremely liberal regarding what is valid HTML5.
        This lexer tries to recognize a sensible subset
        (and in certain aspects it's even more permissive than HTML5 itself) 
      </p>

      <p>
        The lexer is smart, and tries to match the opening and closing tags
        of an HTML element.

        It is in act an HTML parser, and not only a lexer.

        It will render the text inside an HTML element accoring to the tag name.

        For example, the text inside an <code><em></em></code> element
        will be <em>italic</em> and the element inside an <code>&lt;em&gt;&lt;/em&gt;</code>
        will be <strong>bold</strong>.

        Take a look, for example, at the <a href="#tango">Tango</a> and the
        <a href="#colorful">Colorful</a> styles.

        In the future, hyperlinks will be underlined.
      </p>
      """
    }
  ]


   def html_styles() do
    [
      StyleMap.abap,
      StyleMap.algol,
      StyleMap.algol_nu,
      StyleMap.arduino,
      StyleMap.autumn,
      StyleMap.borland,
      StyleMap.bw,
      StyleMap.colorful,
      StyleMap.default,
      StyleMap.emacs,
      StyleMap.friendly,
      StyleMap.fruity,
      StyleMap.igor,
      StyleMap.lovelace,
      StyleMap.manni,
      StyleMap.monokai,
      StyleMap.murphy,
      StyleMap.native,
      StyleMap.paraiso_dark,
      StyleMap.paraiso_light,
      StyleMap.pastie,
      StyleMap.perldoc,
      StyleMap.rainbow_dash,
      StyleMap.rrt,
      StyleMap.tango,
      StyleMap.trac,
      StyleMap.vim,
      StyleMap.vs,
      StyleMap.xcode
    ]
  end

end