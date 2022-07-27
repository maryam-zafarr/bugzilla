# frozen_string_literal: true

User::HABTM_Projects.create!(
  [
    { project_id: 13, user_id: 7 },
    { project_id: 13, user_id: 7 },
    { project_id: 19, user_id: 5 },
    { project_id: 19, user_id: 7 },
    { project_id: 19, user_id: 12 },
    { project_id: 19, user_id: 13 },
    { project_id: 19, user_id: 5 },
    { project_id: 19, user_id: 7 },
    { project_id: 19, user_id: 12 },
    { project_id: 19, user_id: 13 },
    { project_id: 20, user_id: 9 },
    { project_id: 20, user_id: 10 },
    { project_id: 20, user_id: 11 },
    { project_id: 20, user_id: 13 },
    { project_id: 20, user_id: 9 },
    { project_id: 20, user_id: 10 },
    { project_id: 20, user_id: 11 },
    { project_id: 20, user_id: 13 },
    { project_id: 21, user_id: 5 },
    { project_id: 21, user_id: 11 },
    { project_id: 21, user_id: 12 },
    { project_id: 21, user_id: 13 },
    { project_id: 21, user_id: 5 },
    { project_id: 21, user_id: 11 },
    { project_id: 21, user_id: 12 },
    { project_id: 21, user_id: 13 }
  ]
)
Project::HABTM_Users.create!(
  [
    { project_id: 13, user_id: 7 },
    { project_id: 13, user_id: 7 },
    { project_id: 19, user_id: 5 },
    { project_id: 19, user_id: 7 },
    { project_id: 19, user_id: 12 },
    { project_id: 19, user_id: 13 },
    { project_id: 19, user_id: 5 },
    { project_id: 19, user_id: 7 },
    { project_id: 19, user_id: 12 },
    { project_id: 19, user_id: 13 },
    { project_id: 20, user_id: 9 },
    { project_id: 20, user_id: 10 },
    { project_id: 20, user_id: 11 },
    { project_id: 20, user_id: 13 },
    { project_id: 20, user_id: 9 },
    { project_id: 20, user_id: 10 },
    { project_id: 20, user_id: 11 },
    { project_id: 20, user_id: 13 },
    { project_id: 21, user_id: 5 },
    { project_id: 21, user_id: 11 },
    { project_id: 21, user_id: 12 },
    { project_id: 21, user_id: 13 },
    { project_id: 21, user_id: 5 },
    { project_id: 21, user_id: 11 },
    { project_id: 21, user_id: 12 },
    { project_id: 21, user_id: 13 }
  ]
)
User.create!(
  [
    { email: 'marilyn@example.com', encrypted_password: '$2a$12$h448YG.rCXv33BVQZeKjc.rG8cBwdyZp8KCpH8gt1326GliTQtMhq',
      name: 'Marilyn Monroe', user_type: 'quality_assurance_engineer' },
    { email: 'emma@example.com', encrypted_password: '$2a$12$DgV7.UM2pWcD/5x549v07eZjQCuCoAcQtIlhPb2vmM3wHNOmyhmtq',
      name: 'Emma Cox', user_type: 'developer' },
    { email: 'steven@example.com', encrypted_password: '$2a$12$vVfTcXuTsus6ne4SLu.7Z.4uFoLCwtYlxzHULA3yv6M6jKLj8dNSa',
      name: 'Steven Jones', user_type: 'quality_assurance_engineer' },
    { email: 'devin@example.com', encrypted_password: '$2a$12$uDLQ5WMZTLAfSJpuAaTxY.9oCX77Z3.Xj5LM1Szxc4vXK1uJiTEPe',
      name: 'Devin Brook', user_type: 'developer' },
    { email: 'emily.c@example.com', encrypted_password: '$2a$12$4gz8XtBo27eIYbWsMVplt.i1KVfC1ds7hf9jcT1fGRGvRvBmODrKi',
      name: 'Emily Cooper', user_type: 'developer' },
    { email: 'alex.j@example.com', encrypted_password: '$2a$12$wL178KYX00c0Z00Gfd.TcukAug8yIsgdNVEANW9pLwnnlmsX3iz9G',
      name: 'Alex Jones', user_type: 'developer' },
    { email: 'john.doe@example.com', encrypted_password: '$2a$12$gKjU6iJwCANPhTce5uPLYe4nqywdi8s2tkFEM7PZmuGIFE.uMbZkm',
      name: 'John Doe', user_type: 'developer' },
    { email: 'step.wan@example.com', encrypted_password: '$2a$12$CrDrGi1mz2783flUzHyy6OwLOB4C3I.hutRYo2xK/9ijAMp7CDm82',
      name: 'Stephen Wan', user_type: 'quality_assurance_engineer' },
    { email: 'henry.b@example.com', encrypted_password: '$2a$12$KIjTdTf61uUvdE3KhCedq.tsPOo227iL8x7FhtbT5dTt9HiL8cyvO',
      name: 'Henry Bill', user_type: 'manager' },
    { email: 'maryam.z@devsinc.com', encrypted_password: '$2a$12$mc/NddCVSaTBOlX.wwrwaOGBybG.aLVdGy8tPO5U/8lWlU4oxZfJu',
      name: 'Maryam Zafar', user_type: 'manager' },
    { email: 'tom.zane@example.com', encrypted_password: '$2a$12$uwN.Kr490c8qu5lf2lc3X.6nXnyUTPOBtGUSzb8WUOlAY1nWNFBAa',
      name: 'Tom Zane', user_type: 'manager' }
  ]
)
Bug.create!(
  [
    { title: 'Slow search result fetching', bug_type: 'bug', status: 'New', deadline: '2022-07-28', project_id: 19,
      reporter_id: 5, assignee_id: nil, description: 'Contrary to popular belief, Lorem Ipsum is not simply text.' },
    { title: 'Add footer', bug_type: 'feature', status: 'Started', deadline: '2022-07-21', project_id: 20,
      reporter_id: 5, assignee_id: 10, description: '' },
    { title: 'Slow search result fetching', bug_type: 'bug', status: 'New', deadline: '2022-07-21',
      project_id: 20, reporter_id: 9, assignee_id: 11, description: 'Fetching of search results taking over 5s' },
    { title: 'Cart closes on item removal', bug_type: 'bug', status: 'Started', deadline: '2022-07-25',
      project_id: 21, reporter_id: 5, assignee_id: 11, description: 'Lorem Ipsum is not simply random text.' },
    { title: 'Login screen accessibility issues', bug_type: 'bug', status: 'Resolved', deadline: '2022-07-27',
      project_id: 19, reporter_id: 5, assignee_id: 13, description: 'The app doesnt login.' },
    { title: 'Sidebar button not working', bug_type: 'bug', status: 'New', deadline: '2022-07-28',
      project_id: 21, reporter_id: 9, assignee_id: 13, description: 'Buttons not working!' }
  ]
)
Project.create!(
  [
    { title: 'Nixon Training App', description: 'Lorem Ipsum is not simply random text', manager_id: 6 },
    { title: 'Tetra Vision', description: 'Lorem Ipsum is not simply random text.', manager_id: 6 },
    { title: 'Stark Software 243A', description: 'Lorem Ipsum is not simply random text.', manager_id: 6 }
  ]
)
