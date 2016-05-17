defmodule Helper do
  defmacro __using__(_opts) do
    quote location: :keep, bind_quoted: binding do
      def h(text) when is_nil(text) do
        nil
      end

      def h(text) do
        Plug.HTML.html_escape(text)
      end

      def css_path do
        Application.get_env(:web, :assets)[:css]
      end

      def js_path do
        Application.get_env(:web, :assets)[:js]
      end
    end
  end
end
