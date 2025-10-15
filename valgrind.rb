class Valgrind < Formula
  desc "Dynamic analysis tools (memory, debug, profiling)"
  homepage "https://www.valgrind.org/"
  license "GPL-2.0-only"

  head do
    url "https://github.com/LouisBrunner/valgrind-macos.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build

    on_macos do
      on_intel do
        if :arch == :x86 and Xcode.version >= "10.14.6" then
          odie "Valgrind cannot build in 32-bit using Xcode 10.14.6 or later"
        end
      end
    end
  end

  # Valgrind needs vcpreload_core-*-darwin.so to have execute permissions.
  # See #2150 for more information.
  skip_clean "lib/valgrind"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    if ENV["HOMEBREW_I_ACKNOWLEDGE_THIS_MIGHT_CRASH_OR_DAMAGE_MY_COMPUTER"] == "yes"
      ENV["I_ACKNOWLEDGE_THIS_MIGHT_CRASH_OR_DAMAGE_MY_COMPUTER"] = "yes"
    end

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/valgrind", "ls", "-l"
  end
end
