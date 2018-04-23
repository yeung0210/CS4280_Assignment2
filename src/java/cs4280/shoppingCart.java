/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

import java.util.ArrayList;

/**
 *
 * @author yeung0210
 */
public class shoppingCart {
    
    private ArrayList itemsOrdered;
    
    public shoppingCart() {
        itemsOrdered = new ArrayList();
    }
    
    public ArrayList getItemsOrdered() {
        return (itemsOrdered);
    }
    
    public void addItem(Item order) {
        itemsOrdered.add(order);
    }
    
    public int itemNum() {
        return itemsOrdered.size();
    }
    
    
}
