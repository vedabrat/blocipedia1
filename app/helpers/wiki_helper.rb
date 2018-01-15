module WikiHelper

    def markdown(text)
       extensions = [:tables, :fenced_code_blocks, :autolink, :strikethrough, :underline, :highlight, :quote, :footnotes]
       Markdown.new(text, *extensions).to_html.html_safe
    end

  end
end
