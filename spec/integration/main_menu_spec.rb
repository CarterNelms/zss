RSpec.describe "ZSS Main Menu" do
  context "Prints a menu" do
    it "shows a zombie" do
      actual = run_zss_with_input()
      expected = %q{
NUGGGGGH MUST EAT BRAINS
                           \
                                .....
                               C C  /
                              /<   /
               ___ __________/_#__/
              /(- /(\_\________   \
              \ ) \ )_      \o     \
              /|\ /|\       |'     |
                            |     _|
                            /o   __\
                           / '     |
                          / /      |
                         /_/\______|
                        (   _(    <
                         \    \    \
                          \    \    |
                           \____\____\
                           ____\_\__\_\
                         /`   /`     o\
                         |___ |_______|.. .
}
      expect(actual).to include(expected)
    end

    context "when we type an incorrect command" do
      let(:output){ run_zss_with_input('remove') }
      it "prints an informative message" do
        expect(output).to include("I don't know the 'remove' command.")
      end
    end

    it "should print the list of training paths" do
      TrainingPath.create(name: "Running")
      TrainingPath.create(name: "Hand-to-Hand Combat")
      TrainingPath.create(name: "Sneaking")
      actual = run_zss_with_input()
      expected = "1. Running\n" +
                 "2. Hand-to-Hand Combat\n" +
                 "3. Sneaking\n"
      expect(actual).to include(expected)
    end

    it "should print graphs that match the progress down the training paths" do
      pending "implementation of skills"
      fail
    end
  end
end
