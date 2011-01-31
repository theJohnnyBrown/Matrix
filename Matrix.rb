module Matrix
  
  def Matrix.inverse(matrix)
    
  end
  #performs Gauss-Jordan elimination on the given matrix.
  #
  #assumes the matrix is square, if matrix is MxN and N > M, the elimination can 
  #be used to find the inverse or solve a linear system
  #
  #destructive to the matrix given
  def Matrix.gauss_jordan(matrix)
    ech = echelon(matrix)
    ech.reverse!.each_with_index do |row, i|
      other_row = i+1
      while(other_row < ech.length)
        this_row = Array.new(row)
        nz = non_zeros(this_row)
        pivot = nz[0]
        factor = Float(ech[other_row][ech[other_row].length-nz.length])/pivot
        ech[other_row].map! do |el|
          el-factor*this_row.delete_at(0)
        end
        other_row += 1
      end
    end
    ech.reverse
  end
  
  #returns a copy of v with any leading zeros removed
  def Matrix.non_zeros(v, iter=0)
     if(v[0] != 0 or v.length() == 0)
       return v
     else
       return non_zeros(v[iter+1,v.length])
     end
  end
  
  #puts the given matrix in row-echelon form by swapping rows and adding multiples 
  #of them
  def Matrix.echelon(matrix, iter=0)
    return matrix if(iter == matrix.length() -1)
    matrix.slice(iter,matrix.length()).each_with_index do |row, i|
      i += iter
      if(row[iter] != 0)
        matrix = swap(i,iter,matrix)
        break
      end
    end
    
    #this could be a function
    matrix[iter, matrix.length].each_with_index do |row, i|
      i += iter
      first = matrix[iter].slice(iter, matrix[iter].length())
      new_row = row.slice(iter, row.length() )
      factor = Float(new_row[0])/Float(first[0])
      if(i != iter)
        new_row.each_with_index do |el, j|
          new_row[j] = el - (factor*first[j])
        end
        matrix[i] = matrix[i][0,iter] + new_row
      end
    end
    
    return echelon(matrix, iter+1)
  end
  
  #divides every element in row by the first non-zero element
  def Matrix.div_by_pivot(row)
    pivot = Float(non_zeros(row)[0])
    row.map { |el| el/pivot}
  end
  

  #swaps two elements in an array
  def Matrix.swap(i,j,matrix)
    temp = matrix[i]
    matrix[i] = matrix[j]
    matrix[j] = temp
    matrix
  end
end

k = [[1,0,1,1,0,0],[0,1,1,0,1,0],[1,1,0,0,0,1]]
p Matrix.echelon(k)
Matrix.gauss_jordan(k).each do |r|
  p Matrix.div_by_pivot(r)[3,6]
end