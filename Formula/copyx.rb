class Copyx < Formula
  desc "Terminal file and directory copy utility with progress visibility"
  homepage "https://github.com/Toyin5/copyx"
  url "https://github.com/Toyin5/copyx/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9e58e873e6c1a5f4312e444dd1a42c0fe8635780bca7f5d806f25a580a57b70a"
  license "AGPL-3.0-only"

  depends_on "dotnet" => :build

  def install
    rid = Hardware::CPU.arm? ? "osx-arm64" : "osx-x64"

    system "dotnet", "publish", "src/CopyX.csproj",
           "--configuration", "Release",
           "--runtime", rid,
           "--self-contained", "true",
           "--output", libexec,
           "/p:PublishSingleFile=true",
           "/p:PublishTrimmed=false",
           "/p:DebugType=None",
           "/p:DebugSymbols=false",
           "/p:Version=#{version}"

    bin.install_symlink libexec/"CopyX" => "copyx"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/copyx --help")
  end
end

