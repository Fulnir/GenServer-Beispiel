defmodule GenTest.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = GenTest.Registry.start_link
    {:ok, registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert GenTest.Registry.lookup(registry, "shopping") == :error

    GenTest.Registry.create(registry, "shopping")
    assert {:ok, bucket} = GenTest.Registry.lookup(registry, "shopping")

    GenTest.Bucket.put(bucket, "milk", 1)
    assert GenTest.Bucket.get(bucket, "milk") == 1
  end
end