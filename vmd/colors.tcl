proc load_color_definitions {} {
  color change rgb 33 0.3 0.3 0.3
  catch {color Name O pink}
  catch {color Name Ti white}
  catch {color Element Ti silver}
  catch {color Element Ni silver}
  catch {color Element Co silver}
  catch {color Element Al gray}
  catch {color Element Nb green}
  catch {color Element Na green}
  catch {color Element C 33}
  color Labels Bonds black
  color Labels Angles blue
}
