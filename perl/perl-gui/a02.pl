#! /c/Perl/bin/perl.exe -w
#

use Tkx;

# Initialize our country "databases":
#  - the list of country codes (a subset anyway)
#  - a parallel list of country names, in the same order as the country codes
#  - a hash table mapping country code to population
@countrycodes = ("ar", "au", "be", "br", "ca", "cn", "dk", "fi", "fr", "gr", "in", "it", "jp", "mx", 
                "nl", "no", "es", "se", "ch");
@countrynames = ("Argentina", "Australia", "Belgium", "Brazil", "Canada", "China", "Denmark", 
        "Finland", "France", "Greece", "India", "Italy", "Japan", "Mexico", "Netherlands", "Norway", "Spain", 
        "Sweden", "Switzerland");
%populations = ("ar" => 41000000, "au" => 21179211, "be" => 10584534, "br" => 185971537, 
        "ca" => 33148682, "cn" => 1323128240, "dk" => 5457415, "fi" => 5302000, "fr" => 64102140, "gr" => 11147000, 
        "in" => 1131043000, "it" => 59206382, "jp" => 127718000, "mx" => 106535000, "nl" => 16402414, 
        "no" => 4738085, "es" => 45116894, "se" => 9174082, "ch" => 7508700);

# Names of the gifts we can send
%gifts =("card" => "Greeting card", "flowers" => "Flowers", "nastygram" => "Nastygram");

# Create and grid the outer content frame
$mw = Tkx::widget->new(".");
$content = $mw->new_ttk__frame(-padding => "5 5 12 0");
$content->g_grid(-column => 0, -row => 0, -sticky => "nwes");
$mw->g_grid_columnconfigure(0, -weight => 1);
$mw->g_grid_rowconfigure(0, -weight => 1);

# Create the different widgets; note the variables that many
# of them are bound to, as well as the button callback.
# The listbox is the only widget we'll need to refer to directly
# later in our program, so for convenience we'll assign it to a variable.
# Remember that we must use a Tcl formatted list for listvariable.
$cnames = ''; foreach $i (@countrynames) {$cnames = $cnames . ' {' . $i . '}';};
$lbox = $content->new_tk__listbox(-listvariable => \$cnames, -height => 5);
$lbl = $content->new_ttk__label(-text => "Send to country's leader:");
$g1 = $content->new_ttk__radiobutton(-text => $gifts{'card'}, -variable => \$gift, -value => 'card');
$g2 = $content->new_ttk__radiobutton(-text => $gifts{'flowers'}, -variable => \$gift, -value => 'flowers');
$g3 = $content->new_ttk__radiobutton(-text => $gifts{'nastygram'}, -variable => \$gift, -value => 'nastygram');
$send = $content->new_ttk__button(-text => "Send Gift", -command => sub {sendGift()}, -default => 'active');
$l1 = $content->new_ttk__label(-textvariable => \$sentmsg, -anchor => "center");
$l2 = $content->new_ttk__label(-textvariable => \$statusmsg, -anchor => "w");

# Grid all the widgets
$lbox->g_grid(-column => 0, -row => 0, -rowspan => 6, -sticky => "nsew");
$lbl->g_grid(-column => 1, -row => 0, -padx => 10, -pady => 5);
$g1->g_grid(-column => 1, -row => 1, -sticky => "w", -padx => 20);
$g2->g_grid(-column => 1, -row => 2, -sticky => "w", -padx => 20);
$g3->g_grid(-column => 1, -row => 3, -sticky => "w", -padx => 20);
$send->g_grid(-column => 2, -row => 4, -sticky => "e");
$l1->g_grid(-column => 1, -row => 5, -columnspan => 2, -sticky => "n", -pady => 5, -padx => 5);
$l2->g_grid(-column => 0, -row => 6, -columnspan => 2, -sticky => "we");
$content->g_grid_columnconfigure(0, -weight => 1);
$content->g_grid_rowconfigure(0, -weight => 1);


# Set event bindings for when the selection in the listbox changes,
# when the user double clicks the list, and when they hit the Return key
$lbox->g_bind("<<ListboxSelect>>", sub {showPopulation()});
$lbox->g_bind("<Double-1>", sub {sendGift()});
$mw->g_bind("<Return>", sub {sendGift()});

# Called when the selection in the listbox changes; figure out
# which country is currently selected, and then lookup its country
# code, and from that, its population.  Update the status message
# with the new population.  As well, clear the message about the
# gift being sent, so it doesn't stick around after we start doing
# other things.
sub showPopulation {
    my @idx = $lbox->curselection;
    if ($#idx==0) {
        my $code = $countrycodes[$idx[0]];
        my $name = $countrynames[$idx[0]];
        my $popn = $populations{$code};
        $statusmsg = "The population of " . $name . "(" . $code . ") is $popn";
    }
    $sentmsg = "";
}

# Called when the user double clicks an item in the listbox, presses
# the "Send Gift" button, or presses the Return key.  In case the selected
# item is scrolled out of view, make sure it is visible.
#
# Figure out which country is selected, which gift is selected with the 
# radiobuttons, "send the gift", and provide feedback that it was sent.
sub sendGift {
    my @idx = $lbox->curselection;
    if ($#idx==0) {
        $lbox->see($idx[0]);
        my $name =$countrynames[$idx[0]];
        # Gift sending left as an exercise to the reader
        $sentmsg = "Sent " . $gifts{$gift} . " to leader of " . $name
    }     
}

# Colorize alternating lines of the listbox
for ($i=0; $i<=$#countrynames; $i+=2) {
    $lbox->itemconfigure($i, -background => "#f0f0ff");
}

# Set the starting state of the interface, including selecting the
# default gift to send, and clearing the messages.  Select the first
# country in the list; because the <<ListboxSelect>> event is only
# generated when the user makes a change, we explicitly call showPopulation.
$gift = 'card';
$sentmsg = "";
$statusmsg = "";
$lbox->selection_set(0);
showPopulation;

Tkx::MainLoop();

