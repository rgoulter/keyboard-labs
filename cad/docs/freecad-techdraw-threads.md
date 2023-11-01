# Using FreeCad's TechDraw Feature to Indicate Threads

In order to manufacture the CNC case, the locations which need thread holes tapped needs to be
communicated in a technical drawing.

I designed the parametric keyboard case in OpenScad. But, OpenScad isn't well suited to dealing with dimensioned drawings. (Although I do prefer the text-based / "as-code" nature of OpenScad).

To come up with technical drawings, it's easier to use FreeCad.

There's a TechDraw tutorial, but this use case is even simpler than what that covers.

Note, FreeCad Wiki Links:

- FreeCad navigation: https://wiki.freecad.org/Mouse_navigation
- TechDraw Workbench https://wiki.freecad.org/TechDraw_Workbench

Here's how:

1. From OpenScad, render the case to CSG.

```
make ./cnc-pykey40-mx.csg
```

2. Open the CSG file in FreeCad.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/00-open.png" width=600 />

3. Ensure the view is the top of the case, since this is the view we want of the case when communicating where we want threads.

    - I closed the report view.
    - I used the menu options:
      - "View -> Standard Views -> Fit All",
      - and "View -> Standard Views -> Top"

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/01-fittoview.png" width=600 />

4. Change the view to TechDraw.

    - "View -> Workbench -> TechDraw"
      - If TechDraw isn't there, go "Edit -> Preferences -> Workbenches" to enable it.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/02-techdraw-perspective.png" width=600 />

5. Select the case.

    - Just click on it with the mouse.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/03-selectobject.png" width=600 />

6. Insert Default Page.

    - Find the "Insert Default Page" icon on the toolbar, or otherwise use the menu option "TechDraw -> Page -> Insert Default Page".

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/04-techdraw-newpage.png" width=600 />

7. Insert View.

    - With the case selected,
    - Find the "Insert View" icon on the toolbar, or otherwise use the menu option "TechDraw -> TechDraw Views -> Insert View"

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/05-techdraw-addview.png" width=600 />

    - I scale this view down.
      - With the View selected,
      - In the "Combo View" on the left, in the "Data" tab,
        - Change Scale type to "Custom".
        - Change Scale to an appropriate value.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/06-techdraw-scaleddown.png" width=600 />

Now you've got a FreeCad document set up which can suitably communicate the appropriate technical details.

### TechDraw Features I Used

In this use case, the technical information I want to communicate is very simple.

- Horizontal/Vertical Dimensions:

    - Select the two lines for the dimension to describe.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/07-techdraw-dimensionsel.png" width=600 />

    - Under "Combo View", "View" tab, I adjust the Arrowsize and Fontsize.
    - The location of the dimension can be changed by:
      - Dragging the dimension with the mouse,
      - or by setting the X, Y values in the "Data" tab.

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/08-techdraw-dimension.png" width=600 />

- Circle Centerlines

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/09-techdraw-radiussel.png" width=600 />

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/10-techdraw-radius.png" width=600 />

- Cosmetic Line through 2 Points

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/11-techdraw-linesel.png" width=600 />

<img src="https://raw.githubusercontent.com/rgoulter/keyboard-labs/master/cad/docs/images/freecad-techdraw-threads/12-techdraw-lineconfig.png" width=600 />

I have 5 threads of the same diameter and depth, so I just describe that in an annotation.

