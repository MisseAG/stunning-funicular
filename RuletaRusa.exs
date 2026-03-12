defmodule RuletaRusa do

  def iniciar do
    jugadores = [
    %{id: 1, nombre: "Alejandro", vivo: true},
    %{id: 2, nombre: "Sebastián", vivo: true},
    %{id: 3, nombre: "Samuel", vivo: true},
    %{id: 4, nombre: "Augusto", vivo: true},
  ]
    menu(jugadores)
  end

  def menu(jugadores) do
    IO.puts("\n===== RULETA RUSA =====")
    IO.puts("1. Crear jugador")
    IO.puts("2. Ver jugadores")
    IO.puts("3. Actualizar jugador")
    IO.puts("4. Eliminar jugador")
    IO.puts("5. Jugar ruleta")
    IO.puts("6. Salir")

    opcion = Util.ingresar("Seleccione: ", :entero)

    case opcion do
      1 ->
        jugadores = crear(jugadores)
        menu(jugadores)

      2 ->
        ver(jugadores)
        menu(jugadores)

      3 ->
        jugadores = actualizar(jugadores)
        menu(jugadores)

      4 ->
        jugadores = eliminar(jugadores)
        menu(jugadores)

      5 ->
        jugadores = jugar(jugadores)
        menu(jugadores)

      6 ->
        IO.puts("Fin del juego")

      _ ->
        IO.puts("Opcion invalida")
        menu(jugadores)
    end
  end


  # CREATE
  def crear(jugadores) do
    nombre =
      Util.ingresar("Nombre del jugador: ", :texto)
      |> String.trim()

    jugador = %{
      id: Enum.count(jugadores) + 1,
      nombre: nombre,
      vivo: true
    }

    jugadores ++ [jugador]
  end


  # READ
  def ver(jugadores) do
    IO.puts("\n--- JUGADORES ---")

    Enum.each(jugadores, fn j ->
      estado =
        if j.vivo do
          "Vivo"
        else
          "Muerto"
        end

      IO.puts("ID #{j.id} | #{j.nombre} | #{estado}")
    end)
  end


  # UPDATE
  def actualizar(jugadores) do
    id = Util.ingresar("ID del jugador: ", :entero)

    nuevo_nombre =
      Util.ingresar("Nuevo nombre: ", :texto)
      |> String.trim()

    Enum.map(jugadores, fn j ->
      if j.id == id do
        Map.put(j, :nombre, nuevo_nombre)
      else
        j
      end
    end)
  end


  # DELETE
  def eliminar(jugadores) do
    id = Util.ingresar("ID a eliminar: ", :entero)

    Enum.filter(jugadores, fn j ->
      j.id != id
    end)
  end


  # JUEGO RULETA
  def jugar(jugadores) do
    vivos = Enum.filter(jugadores, fn j -> j.vivo end)

    if Enum.empty?(vivos) do
      IO.puts("No hay jugadores vivos")
      jugadores
    else
      ver(vivos)

      id = Util.ingresar("Elige jugador: ", :entero)

      case Enum.find(jugadores, fn j -> j.id == id end) do
        nil ->
          IO.puts("Jugador no encontrado")
          jugadores

        jugador ->

          tambor = [:blank, :blank, :blank, :blank, :blank, :live]

          disparo = Enum.random(tambor)

          case disparo do
            :live ->
              IO.puts(" ¡BALA! #{jugador.nombre} murió")

              Enum.map(jugadores, fn j ->
                if j.id == id do
                  %{j | vivo: false}
                else
                  j
                end
              end)

            :blank ->
              IO.puts(" Click... #{jugador.nombre} sobrevivió")
              jugadores
          end
      end
    end
  end
end


RuletaRusa.iniciar()
