/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

/**
 *
 * @author yeung0210
 */
public class Item {
    
    private String book_ID;
    private String book_name;
    private String book_author;
    private double book_price;
    private int book_quantity;
    
    public Item(String ID, String name, String author, double price) {
        this.book_ID = ID;
        this.book_name = name;
        this.book_author = author;
        this.book_price = price;
        this.book_quantity = 1;
    }
    
    public String getBookID () {
        return book_ID;
    }
    
    public String getBookName () {
        return book_name;
    }
    
    public String getBookAuthor() {
        return book_author;
    }
    
    public Double getBookPrice() {
        return book_price;
    }
    
    public int getBookQuantity() {
        return book_quantity;
    }
    
    public void increaseQuantity() {
        book_quantity++;
    }
    
}
