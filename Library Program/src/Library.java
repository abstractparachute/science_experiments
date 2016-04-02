import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Library {
    public static void main(String[] args){

        Book book1, book2, book3;

        book1 = new Book("The Great Gatsby", "Fitzgerald", 180);
        book2 = new Book("Eragon", "Paolini", 694);
        book3 = new Book("The Bible", "Jesus", 15000);

        Book[] myLibrary = new Book[] {book1, book2, book3};

        checkExpect(extractTitles(myLibrary), new String[] {"The Great Gatsby", "Eragon", "The Bible"});
        checkExpect(sortByPages(myLibrary), new String[] { "The Great Gatsby", "Eragon", "The Bible"});
        checkExpect(sortByTitle(myLibrary), new String[] {"Eragon", "The Bible", "The Great Gatsby"});
        checkExpect(sortByAuthor(myLibrary), new String[] {"The Great Gatsby", "The Bible", "Eragon"});

    }

    static <T> ArrayList<T> arrayToArrayList(T[] array) {
        ArrayList<T> result = new ArrayList<T>(array.length);

        for (T s : array) {
            result.add(s);
        }
        return result;
    }
    static <T> void checkExpect(T actual, T expected) {
        if (actual instanceof Object[] && expected instanceof Object[]) {
            checkExpect(arrayToArrayList((Object[])actual),
                    arrayToArrayList((Object[])expected));
        } else if (!actual.equals(expected)) {
            throw new RuntimeException("Test failed, expected, " + expected + " but got " + actual);
        }
    }
    static <T> void checkExpect(ArrayList<T> actual, ArrayList<T> expected) {
        if (!actual.equals(expected)) {
            throw new RuntimeException("AL Test failed, expected, " + expected + " but got " + actual);
        }
    }

    static String[] extractTitles(Book[] books){
        ArrayList<String> result = new ArrayList<String>();

        for(int i = 0; i < books.length; i++) {
            result.add((books[i]).title);
        }

        return result.toArray(new String[result.size()]);
    }


     static String[] sortByPages(Book[] books){
         Arrays.sort(books, new CompareByPages());
         return extractTitles(books);
     }

    static String[] sortByTitle(Book[] books){
        Arrays.sort(books, new CompareByTitle());
        return extractTitles(books);
    }

    static String[] sortByAuthor(Book[] books){
            Arrays.sort(books, new CompareByAuthor());
            return extractTitles(books);
    }
}








