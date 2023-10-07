package Book;
use strict;
use warnings;
sub new {
    my $class = shift;
    my $self = {
        title => shift,
        author => shift,
        borrower => undef,
    };
    return bless $self, $class;
}
sub get_title {
    my $self = shift;
    return $self->{title};
}
sub get_author {
    my $self = shift;
    return $self->{author};
}
sub get_borrower {
    my $self = shift;
    return $self->{borrower};
}
sub set_borrower {
    my ($self, $borrower) = @_;
    $self->{borrower} = $borrower;
}
package Author;
use strict;
use warnings;
sub new {
    my $class = shift;
    my $self = {
        name => shift,
        address => shift,
    };
    return bless $self, $class;
}
sub get_name {
    my $self = shift;
    return $self->{name};
}
sub get_address {
    my $self = shift;
    return $self->{address};
}
sub borrow_book {
    my ($self, $book) = @_;
    push @{$self->{borrowed_books}}, $book;
   
 $book->set_borrower($self);
}
sub get_borrowed_books {
    my $self = shift;
    return @{$self->{borrowed_books}};
}
package Borrower;
use strict;
use warnings;
sub new {
    my $class = shift;
    my $self = {
        name => shift,
        address => shift,
        borrowed_books => [],
    };
    return bless $self, $class;
}
sub get_name {
    my $self = shift;
    return $self->{name};
}
sub get_address {
    my $self = shift;
    return $self->{address};
}
sub borrow_book {
    my ($self, $book) = @_;
    push @{$self->{borrowed_books}}, $book;
   
 $book->set_borrower($self);
}
sub get_borrowed_books {
    my $self = shift;
    return @{$self->{borrowed_books}};
}
package Library;
use strict;
use warnings;
sub new {
    my $class = shift;
    my $self = {
        books => [],
        authors => [],
        borrowers => [],
    };
    return bless $self, $class;
}
sub add_book {
    my ($self, $title, $author) = @_;
    my $book = Book->new($title, $author);
    push @{$self->{books}}, $book;
}
sub add_author {
    my ($self, $name, $address) = @_;
    my $author = Author->new($name, $address);
    push @{$self->{authors}}, $author;
}
sub add_borrower {
    my ($self, $name, $address) = @_;
    my $borrower = Borrower->new($name, $address);
    push @{$self->{borrowers}}, $borrower;
}
sub find_book_by_title {
    my ($self, $title) = @_;
    foreach my $book (@{$self->{books}}) {
        if ($book->get_title() eq $title) {
            return $book;
        }
    }
    return undef;
}
sub find_author_by_name {
    my ($self, $name) = @_;
    foreach my $author (@{$self->{authors}}) {
        if ($author->get_name() eq $name) {
            return $author;
        }
    }
    return undef;
}
sub find_borrower_by_name {
    my ($self, $name) = @_;
    foreach my $borrower (@{$self->{borrowers}}) {
        if ($borrower->get_name() eq $name) {
            return $borrower;
        }
    }
    return undef;
}
sub borrow_book {
    my ($self, $book_title, $borrower_name) = @_;
    my $book = $self->find_book_by _title($book_title);
    my $borrower = $self->find_borrower_by_name($borrower_name);
    if ($book && $borrower) {
        $borrower->borrow_book($book);
    }
}
sub return_book {
    my ($self, $book_title, $borrower_name) = @_;
    my $book = $self->find_book_by_title($book_title);
    my $borrower = $self->find_borrower_by_name($borrower_name);
    if ($book && $borrower) {
        $borrower->return_book($book);
    }
}
sub list_all_books {
    my $self = shift;
    foreach my $book (@{$self->{books}}) {
        print $book->get_title() . "\n";
    }
}
sub list_all_authors {
    my $self = shift;
    foreach my $author (@{$self->{authors}}) {
        print $author->get_name() . "\n";
    }
}
sub list_all_borrowers {
    my $self = shift;
    foreach my $borrower (@{$self->{borrowers}}) {
        print $borrower->get_name() . "\n";
    }
}
package main;
use strict;
use warnings;
my $library = Library->new();
$library->add_book("The Lord of the Rings", "J.R.R. Tolkien");
$library->add_book("The Hobbit", "J.R.R. Tolkien");
$library->add_book("The Silmarillion", "J.R.R. Tolkien");
$library->add_author("J.R.R. Tolkien", "Oxford, England");
$library->add_borrower("Frodo Baggins", "The Shire");
$library->add_borrower("Samwise Gamgee", "The Shire");
$library->add_borrower("Merry Brandybuck", "The Shire");
$library->add_borrower("Pippin Took", "The Shire");
$library->borrow_book("The Lord of the Rings", "Frodo Baggins");
$library->borrow_book("The Hobbit", "Samwise Gamgee");
$library->borrow_book("The Silmarillion", "Merry Brandybuck");
$library->return_book("The Lord of the Rings", "Frodo Baggins");
$library->return_book("The Hobbit", "Samwise Gamgee");
$library->return_book("The Silmarillion", "Merry Brandybuck");
$library->list_all_books();
$library->list_all_authors();
$library->list_all_borrowers();
