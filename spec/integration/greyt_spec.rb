describe 'API' do

    path '/api/v1/presenterquestionanswers' do
        post 'Creates a presenterquestionanswer' do
            tags 'Rateflow'
            consumes 'application/json', 'application/xml'
            parameter name: :presenterquestionanswer, in: :body, schema: {
                type: :object,
                properties: {
                  answer: { type: :string },
                  presenterquestion_id: { type: :integer },
                  user_id: { type: :integer }
                },
                required: [ 'answer', 'presenterquestion_id', 'user_id' ]
              }
    
              response '201', 'presenterquestionanswer created' do
                let(:presenterquestionanswer) { { answer: 'Answer', id: 1, presenterquestion_id:1, user_id:1  } }
                run_test!
              end
    
              response '422', 'invalid request' do
                let(:presenterquestionanswer) { { answer: 'foo' } }
                run_test!
              end
        end
        


    end



    path '/api/v1/presenterquestions' do
        post 'Creates a presenterquestion' do
            tags 'Rateflow'
            consumes 'application/json', 'application/xml'
            parameter name: :presenterquestion, in: :body, schema: {
                type: :object,
                properties: {
                  title: { type: :string },
                  project_id: { type: :integer }
                },
                required: [ 'title', 'project_id']
              }
    
              response '201', 'presenterquestion created' do
                let(:presenterquestion) { { title: 'Title', id: 1, project_id:1  } }
                run_test!
              end
    
              response '422', 'invalid request' do
                let(:presenterquestion) { { title: 'foo' } }
                run_test!
              end
        end
        


    end



    path '/api/v1/presenterquestions' do
        post 'Creates a lesson' do
            tags 'Advisors'
            consumes 'application/json', 'application/xml'
            parameter name: :presenterquestion, in: :body, schema: {
                type: :object,
                properties: {
                    name: { type: :string },
                    token: { type: :string },
                    project_id: { type: :integer },
                    start: { type: :datetime },
                    end: { type: :datetime },
                    conversation_id: { type: :integer },
                    teacher_id: { type: :integer },
                    student_id: { type: :integer },
                    minutes: { type: :integer },
                    pronunciation_rate: { type: :integer },
                    knowledge_rate: { type: :integer },
                    explanation_rate: { type: :integer },
                    positive_comment: { type: :string },
                    negative_comment: { type: :string }
                },
                required: [ 'student_id', 'teacher_id',  'conversation_id', 'project_id']
              }
    
              response '201', 'presenterquestion created' do
                let(:presenterquestion) { { title: 'Title', id: 1, project_id:1  } }
                run_test!
              end
    
              response '422', 'invalid request' do
                let(:presenterquestion) { { title: 'foo' } }
                run_test!
              end
        end
        


    end

end