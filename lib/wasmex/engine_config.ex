defmodule Wasmex.EngineConfig do
  @moduledoc ~S"""
  Configures a `Wasmex.Engine`.

  ## Options

    * `:consume_fuel` - Whether or not to consume fuel when executing WASM instructions. This defaults to `false`.
    * `:wasm_backtrace_details` - Whether or not backtraces in traps will parse debug info in the WASM file to have filename/line number information. This defaults to `false`.

  ## Example

      iex> _config = %Wasmex.EngineConfig{}
      ...>           |> Wasmex.EngineConfig.consume_fuel(true)
      ...>           |> Wasmex.EngineConfig.wasm_backtrace_details(false)
  """

  defstruct consume_fuel: false,
            wasm_backtrace_details: false

  @type t :: %__MODULE__{
          consume_fuel: boolean(),
          wasm_backtrace_details: boolean()
        }

  @doc ~S"""
  Configures whether execution of WebAssembly will "consume fuel" to
  either halt or yield execution as desired.

  This can be used to deterministically prevent infinitely-executing
  WebAssembly code by instrumenting generated code to consume fuel as it
  executes. When fuel runs out a trap is raised.

  Note that a `Wasmex.Store` starts with no fuel, so if you enable this option
  you'll have to be sure to pour some fuel into `Wasmex.Store` before
  executing some code. See `Wasmex.StoreOrCaller.add_fuel/2`.

  ## Example

      iex> config = %Wasmex.EngineConfig{}
      ...>          |> Wasmex.EngineConfig.consume_fuel(true)
      iex> config.consume_fuel
      true
  """
  @spec consume_fuel(t(), boolean()) :: t()
  def consume_fuel(%__MODULE__{} = config, consume_fuel) do
    %__MODULE__{config | consume_fuel: consume_fuel}
  end

  @doc ~S"""
  Configures whether backtraces in traps will parse debug info in the WASM
  file to have filename/line number information.

  When enabled this will causes modules to retain debugging information
  found in WASM binaries. This debug information will be used when a trap
  happens to symbolicate each stack frame and attempt to print a
  filename/line number for each WASM frame in the stack trace.

  ## Example

      iex> config = %Wasmex.EngineConfig{}
      ...>          |> Wasmex.EngineConfig.wasm_backtrace_details(true)
      iex> config.wasm_backtrace_details
      true
  """
  @spec wasm_backtrace_details(t(), boolean()) :: t()
  def wasm_backtrace_details(%__MODULE__{} = config, wasm_backtrace_details) do
    %__MODULE__{config | wasm_backtrace_details: wasm_backtrace_details}
  end
end
