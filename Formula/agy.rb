# Homebrew formula for agentry (agy).
#
# Intended for a tap (e.g. `OpenTechIL/homebrew-tap`): `brew install OpenTechIL/tap/agy`.
# `version` and the per-asset `sha256` values are release-specific — release automation
# fills them from SHA256SUMS.txt (see packaging/README.md). The 64-zero shas below are
# placeholders so the structure is reviewable before the first tagged release.
class Agy < Formula
  desc "Dependency manager for AI coding agents"
  homepage "https://github.com/OpenTechIL/agentry"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agy-#{version}-macos-arm64"
      sha256 "5524b4e3142e5b09d86cfe0dbe900a4a5e15a8e2f7f9ce5ee87c446e354c4663"
    end
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agy-#{version}-macos-x86_64"
      sha256 "d7d44a7d3619b74741e0271582ef8c9eb4f23abfd55e00cc8ed4968c173d82bc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agy-#{version}-linux-x86_64"
      sha256 "130af93a690b20dd980b8696cbd8fc6e2a9f73460a21a194ac0d389ae5535f16"
    end
    # linux-arm64 has no prebuilt binary yet (see install.sh); use `uv tool install`.
  end

  def install
    # The release asset is the bare binary, named agy-<version>-<target>.
    bin.install Dir["agy-*"].first => "agy"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agy version")
  end
end
