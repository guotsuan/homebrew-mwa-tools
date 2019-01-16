class Erfa < Formula
  desc "Essential Routines for Fundamental Astronomy"
  homepage "https://github.com/liberfa/erfa"
  url "https://github.com/liberfa/erfa/releases/download/v1.4.0/erfa-1.4.0.tar.gz"
  sha256 "035b7f0ad05c1191b8588191ba4b19ba0f31afa57ad561d33bd5417d9f23e460"

  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test erfa`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
