defmodule Util do
  def mostrar_mensaje(mensaje), do: IO.puts(mensaje)

  def mostrar_error(mensaje), do: IO.puts(:standard_error, mensaje)

  # ---------- Entrada de datos ----------
  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero), do: ingresar(mensaje, &String.to_integer/1, :entero)
  def ingresar(mensaje, :real), do: ingresar(mensaje, &String.to_float/1, :real)

  def ingresar(mensaje, parser, tipo_dato) do
    try do
      mensaje
      |> ingresar(:texto)
      |> parser.()
    rescue
      ArgumentError ->
        mostrar_error("Error, se espera que ingrese un número #{tipo_dato}\n")
        ingresar(mensaje, parser, tipo_dato)
    end
  end
end
