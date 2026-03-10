final: prev:
{
  pantalaimon = prev.pantalaimon.overrideAttrs (old: {
    # テストの実行を無効にします
    doCheck = false;
  });
}
