/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cs4280;

/**
 *
 * @author yu
 */
public class Member {
    
    private String member_name;
    private int member_loyalty_point;
    
    public Member (String name, int loyalty_point) {
        this.member_name = name;
        this.member_loyalty_point = loyalty_point;
    }
    
    public int getLyaltyPoint() {
        return member_loyalty_point;
    }

    
}
