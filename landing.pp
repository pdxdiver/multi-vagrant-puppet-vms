class profiles::landing (String $myFile) {
  file { $myFile:
  ensure=> present,
  source => 'http://raw.githubusercontent.com/puppetlabs/exercise-webpage/master/index.html',
  }
}
