package DDG::Goodie::FindAnagrams;

use DDG::Goodie;
use File::Slurp qw(read_file write_file);
use File::ShareDir::ProjectDistDir;
use JSON;
use Data::Dumper;

zci is_cached => 1;

triggers start => "fingali";

handle remainder => sub {

    if ($_ eq ""){
	return "No Anagrams Found."
    }

    my $json = read_file(share('words.json'), { binmode => ':raw' }) or die("Unable to open words file");

    my %wordHash = %{decode_json($json)};

    #print Dumper(\%wordHash);

# Format string to look like hash key by making it lowercase then splitting the string into chars, sort them and finally  join back into sorted string
    my $sorted_string = join("",sort(split(//,lc($_))));

    my @resultArray = ();

    if (exists $wordHash{$sorted_string}) {
	push(@resultArray, @{$wordHash{$sorted_string}});
    } else {
	return "No Anagrams Found.";
    }

    my $index = 0;

    $index++ until $resultArray[$index] eq $_;

    splice(@resultArray, $index, 1);

    my $result_string = join(",",@resultArray);

    return (($result_string eq "") ? "No Anagrams Found!" : $result_string);
};

1;
