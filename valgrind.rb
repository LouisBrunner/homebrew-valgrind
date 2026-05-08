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
    on_macos do
      on_arm do
        # Fully break all PSO libs otherwise
        ENV.permit_arch_flags
      end
    end

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

  def post_install
    on_macos do
      on_arm do
        # Make sure that our fake libdyld has the correct install_name_tool,
        # this is done within the configure setup but overwritten by Homebrew
        # so we write it back **again**.
        system "install_name_tool", "-id", "/usr/lib/system/libdyld.dylib", prefix/"libexec/valgrind/libmydyld.so"
        system "codesign", "--force", "--sign", "-", prefix/"libexec/valgrind/libmydyld.so"
        system "install_name_tool", "-id", "/usr/lib/libSystem.B.dylib", prefix/"libexec/valgrind/libmySystem.so"
        system "codesign", "--force", "--sign", "-", prefix/"libexec/valgrind/libmySystem.so"
      end
    end
  end

  test do
    system "#{bin}/valgrind", "ls", "-l"
  end
end
