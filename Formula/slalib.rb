class Slalib < Formula
  desc "Positional Astronomy Library"
  homepage "http://star-www.rl.ac.uk/docs/sun67.htx/sun67.html"
  url "https://github.com/guotsuan/homebrew-mwa-tools/raw/master/files/slalib-2.5.6.tar.gz"
  version "2.5.6"
  sha256 "2b46b338cd945205c48d5ad9843d6b8620a4a9841a00f45985311633f1757fb8"

  depends_on "make" => :build
  depends_on "gcc" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "./configure", "--with-pthreads",
                          "--without-cnf",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test slalib`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
