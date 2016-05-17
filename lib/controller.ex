defmodule Controller do
  defmacro __using__(_opts) do
    quote location: :keep, bind_quoted: binding do
      use Helper
      use Plug.Router
      alias Web.Repo
      import View
      import Plug.HTML
      plug :match
      plug :dispatch
      # Define layout
      view :layout, 'layout/default'

      defdelegate get_csrf_token(), to: Plug.CSRFProtection

      # Renders a view.
      #
      # Example:
      #
      #  conn
      #  |> render(:index, title: "Home")
      #
      defp render(conn, view, assigns \\ [], status \\ 200) do
        # Allow view to access conn.assigns
        assigns = Enum.into(assigns, conn.assigns)
        # Render view by calling, e.g., App.Controller.User.index
        view_body = apply(__MODULE__, view, [assigns])
        # Put rendered view into assigns
        assigns = Map.put(assigns, :view, view_body)
        # Render layout with view
        body = apply(__MODULE__, :layout, [assigns])
        conn
        |> put_resp_content_type("text/html")
        |> send_resp(status, body)
      end

      defp render_text(conn, text) do
        conn
        |> put_resp_content_type("text/html")
        |> send_resp(200, text)
      end

      defp redirect(conn, url) do
        html = Plug.HTML.html_escape(url)
        body = "<html><body>You are being <a href=\"#{html}\">redirected</a>.</body></html>"
        conn
        |> put_resp_header("location", url)
        |> send_resp(302, body)
      end

      defp handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
        send_resp(conn, conn.status, "#{conn.status} Something went wrong")
      end

      defp flash(conn, key, value) do
        conn
        |> put_resp_cookie("flash_#{key}", value, http_only: false)
      end
    end
  end
end
