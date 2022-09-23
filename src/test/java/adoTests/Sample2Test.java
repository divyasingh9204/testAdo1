package adoTests;

import org.junit.Assert;
import org.junit.Test;
import org.junit.Ignore;

public class Sample2Test {

	
    @Test 
    public void test1() { 
        Assert.assertTrue(true);
    }

    @Ignore
    @Test 
    public void ignoretest1() { 
        Assert.assertTrue(true);
    }

}
