# Homebrew formula for agentry.
#
# Intended for a tap (e.g. `OpenTechIL/homebrew-tap`): `brew install OpenTechIL/tap/agentry`.
# `version` and the per-asset `sha256` values are release-specific — release automation
# fills them from SHA256SUMS.txt (see packaging/README.md). The 64-zero shas below are
# placeholders so the structure is reviewable before the first tagged release.
class Agentry < Formula
  desc "Dependency manager for AI coding agents"
  homepage "https://github.com/OpenTechIL/agentry"
  version "0.3.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-arm64"
      sha256 "006bf4474ebc0627357b13a3466e20417156875b1f9aed94666203e23c099b6f"
    end
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-x86_64"
      sha256 "7dbb0646d18d510030228c05821dd74d08ff8072b9d5a75fded2fbe22e9f2b5f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-linux-x86_64"
      sha256 "3e8806951f228ff9b6973ad93c59781fdfd736e7af87fbdf42169539b20bd184"
    end
    # linux-arm64 has no prebuilt binary yet (see install.sh); use `uv tool install`.
  end

  def install
    # The release asset is the bare binary, named agentry-<version>-<target>.
    bin.install Dir["agentry-*"].first => "agentry"
    # Short aliases. `agy` is kept for back-compat, but Google's Antigravity CLI also
    # claims that name — `agyx` is the short name that cannot collide. Homebrew prints its
    # own caveat when a linked binary is shadowed on PATH.
    bin.install_symlink bin/"agentry" => "agy"
    bin.install_symlink bin/"agentry" => "agyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agentry version")
  end
end
