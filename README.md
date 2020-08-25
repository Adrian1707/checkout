## Instructions

This was written using Ruby 2.5.0

Prerequisites: bundler, git, ruby

1. Clone this repo using `git clone https://github.com/Adrian1707/checkout`
2. Run `bundle install`
3. Run `rspec`

The approach taken in this challenge was to make the checkout design as flexible as possible by
having zero coupling to the implementation details of each promotion. Details such as the discount
threshold and amount of discount to apply are nested inside their respective promotion classes.
This is in the spirit of the Open/Closed principle, insisting that classes should be open for extension
but closed for modification. When we want to add a new promotion it's simply a case of writing
a new class and plugging it in to the checkout constructor.

The integration spec `checkout_integration_spec.rb` was written to ensure all the requirements in the
challenge instructions were fulfilled and also to provide a final sanity check on the functionality.

In terms of the public interface of Checkout, it's arguable that `display_total` is not required as
it wasn't part of the agreed interface in the challenge instructions. However for the purposes of the
integration specs I added it in for completeness. Given that it's purely presentation logic the method stands out from the rest of the public API, but it's small and innocent enough for now to be mixed in with the rest.
