trigger HelloWorld on Lead (before update) {
    for(Lead l:Trigger.new)
    {
        l.firstname='Hello';
        l.lastname='World';
    }

}