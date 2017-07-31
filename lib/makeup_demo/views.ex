defmodule MakeupDemo.Views do

  require EEx
  EEx.function_from_file(:defp, :render_index_templ, "lib/makeup_demo/templates/index.html.eex", [:assigns])
  EEx.function_from_file(:defp, :render_language_templ, "lib/makeup_demo/templates/language.html.eex", [:assigns])
  EEx.function_from_file(:defp, :render_layout_templ, "lib/makeup_demo/templates/layout.html.eex", [:assigns])

  def common_assigns() do
    [
      languages: MakeupDemo.Languages.languages(),
      html_styles: MakeupDemo.Languages.html_styles(),
      sidebar_styles: false
    ]
  end

  def render_language(%{slug: slug} = language) do

    inner_assigns = common_assigns()
    |> Keyword.merge([
      language: language,
      sources: MakeupDemo.Languages.get_sources(slug)
    ])

    common_assigns()
    |> Keyword.merge([
        sidebar_styles: true,
        document_content: render_language_templ(inner_assigns)
    ])
    |> render_layout_templ()
  end

  def render_index() do
    common_assigns()
    |> Keyword.put(:document_content,
                   render_index_templ(common_assigns()))
    |> render_layout_templ()
  end
end