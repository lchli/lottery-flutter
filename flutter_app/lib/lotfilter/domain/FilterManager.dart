import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutterapp/lotfilter/domain/FilterCondition.dart';

class FilterManager {

  List<FilterCondition> _filters = [];
  List<String> _out;
  int _mLevel;


  int getFilterSize() {
    return _filters.length;
  }

  ///
  /// @param dataSource
  /// @return the same list has been filtered.
  List<String> runFilter(List<String> dataSource) {
    if (_filters.isEmpty) {
      return dataSource;
    }

    for (FilterCondition condition in _filters) {
      condition.doFilter(dataSource);
    }

    return dataSource;
  }

  void addFilter(FilterCondition filter) {
    _filters.add(filter);
  }

 
  List<String> _rongCuoFilterN(List<String> dataSource, int level) {
    final int filterSize = _filters.length;
    if (level == 0)
      return runFilter(dataSource);

    _out = null;
    _mLevel = level;

    _rongCuo(level, filterSize, 0, dataSource);
    return _out;
  }

  /**
   *
   * @param dataSource
   * @param levels
   * @return a new list.
   */
  List<String> runRongCuoFilter(List<String> dataSource,
      List<int> levels) {
    List<String> ret;

    for (int level in levels) {
      List<String> temp = _rongCuoFilterN(
          List.of(dataSource), level);
      if (ret == null)
        ret = temp;
      else { // union.
//        ret.removeAll(temp);
//        ret.addAll(temp);

        for( String e in temp) {
          if(!ret.contains(e)) {
            ret.add(e);
          }
        }//for
        
      }



    }//for

    return ret;
  }

  void _rongCuo(int level, final int filterSize, int start,
      final List<String> dataSource) {
    for (int i = start; i < filterSize; i++) {
      //filters.get(i).setUnFilter(true);
      _filters[i] = _filters[i].reverseCondition();
      if (level > 0)
        level--;
      if (level > 0) {
        _rongCuo(level, filterSize, i + 1, dataSource);
        // filters.get(i).setUnFilter(false);
        _filters[i] = _filters[i].reverseCondition(); //restore
        level = _mLevel;
      } else {
        List<String> temp = runFilter(List.of(dataSource));
            //filters.get(i).setUnFilter(false);
            _filters[i]=_filters[i].reverseCondition(); //restore
        if (_out == null)
          _out = temp;
        else {
         // out.removeAll(temp);
          for( String e in temp) {
            if(!_out.contains(e)) {
              _out.add(e);
            }
          }//for
          
        }
      }
    }
  }
}
