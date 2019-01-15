class CasacoreData < Formula
  desc "Ephemerides and geodetic data for casacore measures (via ATNF)"
  homepage "https://github.com/casacore/casacore"
  url "ftp://ftp.atnf.csiro.au/pub/software/measures_data/measures_data.tar.bz2"
  sha256 "27cd4ecb6c0bd49346f84fdb7d9f0f2228f590470684b04ec0e571a0b77787c8"

  option "use-casapy", 'Use Mac CASA.App (aka casapy) data directory if found'

  def casapy_data; "/Applications/CASA.app/Contents/data"; end

  def install
    if (build.include? "use-casapy") and (File.exist? casapy_data+'/ephemerides')
      mkdir_p "#{share}/casacore"
      ln_s "#{casapy_data}", "#{share}/casacore/data"
    else
      mkdir_p "#{share}/casacore/data"
      cp_r Dir['*'], "#{share}/casacore/data/"
    end
  end

  def caveats
    if File.symlink? "#{share}/casacore/data"
      "Linked to CASA data directory #{casapy_data}"
    else
      "Installed latest ATNF measures_data tarball"
    end
  end
end

