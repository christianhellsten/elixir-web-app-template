defmodule View do
  require Slime
  @doc """
   Defines a view function. Returns a rendered EEx template.
  """
  defmacro view(function_name, file, args \\ [:assigns]) do
    quote location: :keep, bind_quoted: binding do
      require EEx
      import EEx.Engine
      opts = []
      eex = "view/#{file}.slim" |> File.read! |> Slime.Renderer.precompile
      # Hack for silencing "warning: variable assigns is unused"
      eex = "<% _ = assigns %>" <> eex
      EEx.function_from_string(:def, function_name, eex, args, opts)
    end
  end
end
