# Homebrew formula for agentry.
#
# Intended for a tap (e.g. `OpenTechIL/homebrew-tap`): `brew install OpenTechIL/tap/agentry`.
# `version` and the per-asset `sha256` values are release-specific — release automation
# fills them from SHA256SUMS.txt (see packaging/README.md). The 64-zero shas below are
# placeholders so the structure is reviewable before the first tagged release.
class Agentry < Formula
  desc "Dependency manager for AI coding agents"
  homepage "https://github.com/OpenTechIL/agentry"
  version "0.3.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-arm64"
      sha256 "4a296468b0e8b6ba3f282e8156478de3b2bfa1138ed28850fc87883dd1d3f49a"
    end
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-macos-x86_64"
      sha256 "f5ee8954ba15b4da25f342a9d1d0c5818fad589c33b9b5d418dab9bf3102591f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/OpenTechIL/agentry/releases/download/v#{version}/agentry-#{version}-linux-x86_64"
      sha256 "d302c0ac4e73d132a60eff8bb4d17f7a0f78e8202831d409b39f6452f2365fda"
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
