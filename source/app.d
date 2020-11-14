import std.stdio;

import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.Box;
import gtk.Entry;
import gtk.Button;
import gtk.CssProvider;
import gtk.StyleContext;
import gtk.SpinButton;

private import gtk.ListStore;
private import gtk.TreeIter;
private import gtkc.gobjecttypes;

private import gtk.TreeView;
private import gtk.TreeViewColumn;
private import gtk.ListStore;
private import gtk.CellRendererText;
private import gtk.ListStore;

class CSS // GTK4 compliant
{
	CssProvider provider;
	string cssPath = "./app.css";
	StyleContext context;

	this(StyleContext styleContext)
	{
		provider = new CssProvider();
		provider.loadFromPath(cssPath);
		//provider.loadFromData(cssString);
		styleContext.addProvider(provider, GTK_STYLE_PROVIDER_PRIORITY_APPLICATION);
		context = styleContext;
	} 

	void addClass(string className){
		context.addClass(className);
	}
	
} // class CSS

class CountryListStore : ListStore
{
    this()
    {
        super([GType.STRING, GType.STRING]);
    }
   
    public void addCountry(in string name, in string capital)
    {
        TreeIter iter = createIter();
        setValue(iter, 0, name);
        setValue(iter, 1, capital);
    }
}

class CountryTreeView : TreeView
{
    private TreeViewColumn countryColumn;
    private TreeViewColumn capitalColumn;
   
    this(ListStore store)
    {       
        // Add Country Column
        countryColumn = new TreeViewColumn("Country", new CellRendererText(), "text", 0);
        appendColumn(countryColumn);
       
        // Add Capital Column
        capitalColumn = new TreeViewColumn("Capital", new CellRendererText(), "text", 1);
        appendColumn(capitalColumn);
       
        setModel(store);
    }
}


void main(string[] args)
{
    Main.init(args);
    MainWindow win = new MainWindow("Hello World");
    win.setDefaultSize(500, 300);
    // win.setPosition(WindowPosition.CENTER);

    auto container = new Box(Orientation.VERTICAL, 5);
    container.setSpacing(10);
    container.setName("container");
    new CSS(container.getStyleContext());

    //css = "{ background-color: #f00; }";
    // autp cssProvider = CssProvider();
    // cssProvider.loadFromData(css);
    //auto context = StyleContext();
  

    // box.padding = 5;


    auto label = new Label("Name");
    label.setXalign = false;

    auto input = new Entry();

    auto btn = new Button("Save");
    btn.setName("btn");
    auto btnCSS = new CSS(btn.getStyleContext());
    btnCSS.addClass("btn_class");

    auto box = new Box(Orientation.VERTICAL, 2);
    box.packStart(label, false, false, 2);
    box.packStart(input, false, false, 2);
    box.packStart(btn, false, false, 2);

    auto spinBox = new Box(Orientation.VERTICAL, 2);
    auto spinBtn = new SpinButton(1, 100, 1);
    spinBox.packStart(spinBtn, false, false, 2);


    auto listBox = new Box(Orientation.VERTICAL, 2);
    
    auto countryListStore = new CountryListStore();
    countryListStore.addCountry("Denmark", "Copenhagen");
    countryListStore.addCountry("Norway", "Olso");
    countryListStore.addCountry("Sweden", "Stockholm");
   
    auto countryTreeView = new CountryTreeView(countryListStore);    
	listBox.packStart(countryTreeView, false, false, 2);

    // container.packStart(box, false, false, 2);
    // container.packStart(spinBox, false, false, 2);
    container.packStart(listBox, false, false, 2);
    win.add(container);

    win.showAll();
    Main.run();
}
