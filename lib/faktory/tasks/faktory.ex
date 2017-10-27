defmodule Mix.Tasks.Faktory do
  @moduledoc """
  Use this to start up the worker and start shreddin through your work!

  `mix faktory`

  Currently it doen not take any arguments; all configuation is done through
  the configuation modules. In the future, I'd like to add command line args
  that take precedence over the config modules. At least
    * `--concurrency`
    * `--queues`
  """

  use Mix.Task
  require Logger

  @shortdoc "Start Faktory worker"

  @doc false
  def run(args) do
    IO.inspect args

    # Signify that we want to start the workers.
    Faktory.put_env(:start_workers, true)

    # Easy enough.
    Mix.Task.run "app.start"

    shh_just_go_to_sleep()
  end

  defp shh_just_go_to_sleep do
    receive do
      something ->
        Logger.warn("!!! Uh oh, main process received a message: #{inspect(something)}")
    end
    shh_just_go_to_sleep()
  end

end
