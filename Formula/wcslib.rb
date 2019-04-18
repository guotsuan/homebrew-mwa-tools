class Wcslib < Formula
  desc "Library and utilities for the FITS World Coordinate System"
  homepage "https://www.atnf.csiro.au/people/mcalabre/WCS/"
  url "ftp://ftp.atnf.csiro.au/pub/software/wcslib/wcslib-6.2.tar.bz2"
  sha256 "bb4dfe242959bc4e5540890e0475754ad4a027dba971903dc4d82df8d564d805"

  depends_on "cfitsio"
  depends_on "pgplot"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-cfitsiolib=#{Formula["cfitsio"].opt_lib}",
                          "--with-cfitsioinc=#{Formula["cfitsio"].opt_include}",
                          "--with-pgplotlib=#{Formula["pgplot"].opt_lib}",
                          "--with-pgplotinc=#{Formula["pgplot"].opt_include}"

    # Currently doesn't support parallel make.  Patch sent to author 2018/08/31.
    # Author (mcalabre@atnf.csiro.au) expects to integrate by end of 2018/09.
    # Patch: https://gist.github.com/dstndstn/0492f69eb27a11cdd622d01105643dd0
    ENV.deparallelize
    system "make"
    system "make", "install"
  end

  test do
    piped = "SIMPLE  =" + " "*20 + "T / comment" + " "*40 + "END" + " "*2797
    pipe_output("#{bin}/fitshdr", piped, 0)
  end
end

