package com.PartilhoUX.tool;

public class ColumnModel {
	String value; // represents sortBy / filterBy as one field
    String headerText;

    public ColumnModel(String value, String headerText) {
        this.value = value;
        this.headerText = headerText;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getHeaderText() {
        return headerText;
    }

    public void setHeaderText(String headerText) {
        this.headerText = headerText;
    }
}
