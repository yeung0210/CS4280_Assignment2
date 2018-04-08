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
    
    private String book_name;
    private String book_author;
    private double book_price;
    
    public Item(String name, String author, double price) {
        this.book_name = name;
        this.book_author = author;
        this.book_price = price;
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
    
}
