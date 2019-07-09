#! /bin/bash

function testFunc(){
 echo "hi"       
 declare -n sentArrayOne="$1"
 local sentNum="$2"
  echo "sentArrayOne entry 0 is ${sentArrayOne[0]}"
  echo "sentArrayOne entry 2 is ${sentArrayOne[2]}"
  echo "length sentArrayOne is ${#sentArrayOne[@]}"
  if [[ ${#sentArrayOne[@]} -lt "$sentNum" ]]; then
    echo "LESS THAN"
  else
    echo "MORE THAN"
  fi

  sentArrayOne[0]=0
  sentArrayOne[1]=0
  sentArrayOne[2]=0
  
}

testArray=("a  \/  string" 3 "ano  ther 3*z8**99( stinrg")
echo "testArray BEG 0 entry  ${testArray[0]}"
echo "testArray BEG 1 entry  ${testArray[1]}"
echo "testArray BEG 2 entry  ${testArray[2]}"

testFunc testArray

echo "testArray END 0 entry  ${testArray[0]}"
echo "testArray END 1 entry  ${testArray[1]}"
echo "testArray END 2 entry  ${testArray[2]}"
